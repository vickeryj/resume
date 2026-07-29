#!/usr/bin/env python3
"""Find the horizontal bands where two page renders differ.

Used by build.sh to crop the changed lines out of a page so the diff report can
show them at readable size instead of overlaying two whole pages.

    pagediff.py before.png after.png  ->  "1275 344:402,910:1004"

The first field is the image width in pixels; the rest are y0:y1 bands, also in
pixels. Prints nothing and exits non-zero if the pages cannot be compared, which
build.sh treats as "fall back to whole-page views".

PNG rows are filtered against their predecessors, so decoding one in pure Python
means unfiltering every byte. macOS ships sips, which converts to BMP — an
uncompressed format whose rows can be sliced and compared directly.
"""

import os
import struct
import subprocess
import sys
import tempfile

MERGE_GAP = 20   # px; bands closer than this become one, so a reflowed
PAD = 6          # paragraph reads as a block rather than a stack of slivers
FULL_PAGE_RATIO = 0.7  # beyond this much of the page, just show the whole thing


def to_bmp(png, out):
    subprocess.run(
        ["sips", "-s", "format", "bmp", png, "--out", out],
        check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
    )


def read_rows(path):
    """Return (width, height, [row bytes, top to bottom]) from a BMP."""
    with open(path, "rb") as f:
        data = f.read()
    if data[:2] != b"BM":
        raise ValueError("not a BMP")
    offset, = struct.unpack_from("<I", data, 10)
    width, height, _planes, bpp = struct.unpack_from("<iihh", data, 18)
    if bpp not in (24, 32):
        raise ValueError("unsupported depth %d" % bpp)
    top_down = height < 0
    height = abs(height)
    stride = ((width * bpp + 31) // 32) * 4
    rows = [data[offset + i * stride:offset + (i + 1) * stride]
            for i in range(height)]
    if not top_down:
        rows.reverse()
    return width, height, rows


def bands(before_rows, after_rows):
    """Contiguous runs of differing rows, merged across small gaps."""
    changed = [i for i, (a, b) in enumerate(zip(before_rows, after_rows))
               if a != b]
    tail = abs(len(before_rows) - len(after_rows))
    if tail:
        changed.extend(range(min(len(before_rows), len(after_rows)),
                             max(len(before_rows), len(after_rows))))
    if not changed:
        return []

    out = [[changed[0], changed[0]]]
    for row in changed[1:]:
        if row - out[-1][1] <= MERGE_GAP:
            out[-1][1] = row
        else:
            out.append([row, row])
    return out


def main():
    if len(sys.argv) != 3:
        return 2
    before_png, after_png = sys.argv[1], sys.argv[2]

    with tempfile.TemporaryDirectory() as tmp:
        before_bmp = os.path.join(tmp, "before.bmp")
        after_bmp = os.path.join(tmp, "after.bmp")
        to_bmp(before_png, before_bmp)
        to_bmp(after_png, after_bmp)
        bw, bh, before_rows = read_rows(before_bmp)
        aw, ah, after_rows = read_rows(after_bmp)

    if bw != aw:
        raise ValueError("page width changed")
    height = max(bh, ah)

    found = bands(before_rows, after_rows)
    if not found:
        return 1

    covered = sum(hi - lo + 1 for lo, hi in found)
    if covered > height * FULL_PAGE_RATIO:
        found = [[0, height - 1]]

    padded = []
    for lo, hi in found:
        lo = max(0, lo - PAD)
        hi = min(height - 1, hi + PAD)
        if padded and lo <= padded[-1][1]:
            padded[-1][1] = max(padded[-1][1], hi)
        else:
            padded.append([lo, hi])

    print("%d %s" % (bw, ",".join("%d:%d" % (lo, hi) for lo, hi in padded)))
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception:
        sys.exit(2)
