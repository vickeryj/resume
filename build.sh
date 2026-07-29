#!/usr/bin/env bash
#
# Build résumé/CV PDFs from Typst sources.
#
# Usage:
#   ./build.sh                     Build every target into build/
#   ./build.sh Resume-PE           Build one target (name = targets/<name>.typ)
#   ./build.sh --watch <name>      Rebuild a target on every save
#   ./build.sh --list              List available targets
#   ./build.sh --publish           Build every target, then copy PDFs to iCloud
#   ./build.sh --clean             Remove the build/ directory
#
# Every build also renders each page to a PNG and compares it against the
# previous build's pages, reporting which pages changed. When something moved,
# an overlay report is written to build/diff/index.html; pass --open to open it.
#
set -euo pipefail

cd "$(dirname "$0")"

TARGETS_DIR="targets"
OUT_DIR="build"
PAGES_DIR="$OUT_DIR/.pages"   # last build's rendered pages, for comparison
DIFF_DIR="$OUT_DIR/diff"      # report for the pages that changed this build
DIFF_PPI=150       # page renders used for comparison; high enough to read at 200%
PUBLISH_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

OPEN_DIFF=0

# Cropping the changed lines out of a page needs python3 and sips (macOS).
# Without them the report still works, just whole pages only.
BAND_TOOL="tools/pagediff.py"
BANDS_OK=0
if [ -f "$BAND_TOOL" ] && command -v python3 >/dev/null 2>&1 &&
   command -v sips >/dev/null 2>&1; then
  BANDS_OK=1
fi

if ! command -v typst >/dev/null 2>&1; then
  echo "error: typst is not installed. Install it with: brew install typst" >&2
  exit 1
fi

TMP_RENDER="$(mktemp -d)"
DIFF_LOG="$(mktemp)"
trap 'rm -rf "$TMP_RENDER" "$DIFF_LOG"' EXIT

list_targets() {
  for f in "$TARGETS_DIR"/*.typ; do
    [ -e "$f" ] || continue
    basename "$f" .typ
  done
}

# Renders at a different resolution would all compare as changed, so a DIFF_PPI
# change discards the cache and re-baselines instead.
check_cache_ppi() {
  local marker="$PAGES_DIR/.ppi"
  if [ -d "$PAGES_DIR" ] && [ "$(cat "$marker" 2>/dev/null)" != "$DIFF_PPI" ]; then
    rm -rf "$PAGES_DIR"
  fi
  mkdir -p "$PAGES_DIR"
  echo "$DIFF_PPI" >"$marker"
}

page_count() {
  local dir="$1" n=0 f
  for f in "$dir"/p*.png; do
    [ -e "$f" ] || continue
    n=$((n + 1))
  done
  echo "$n"
}

# "<width> <y0:y1,…>" for the rows of a page that changed, so the report can crop
# them out. Silent (and the report falls back to whole pages) if unavailable.
locate_bands() {
  [ "$BANDS_OK" = 1 ] || return 0
  python3 "$BAND_TOOL" "$1" "$2" 2>/dev/null || true
}

# Render every page of a target and compare it to the previous build, logging
# each differing page to DIFF_LOG as
# "<name> <page> <changed|added|removed> <width> <y0:y1,y0:y1>", where the
# trailing fields locate the changed bands and are empty when unavailable.
diff_pages() {
  local name="$1"
  local new_dir="$TMP_RENDER/$name"
  local old_dir="$PAGES_DIR/$name"

  rm -rf "$new_dir"
  mkdir -p "$new_dir" "$PAGES_DIR"
  typst compile --root . "$TARGETS_DIR/$name.typ" "$new_dir/p{p}.png" \
    --format png --ppi "$DIFF_PPI"

  if [ ! -d "$old_dir" ]; then
    echo "  baseline recorded (no previous build to compare)"
    mv "$new_dir" "$old_dir"
    return
  fi

  local new_n old_n max i changed=""
  new_n="$(page_count "$new_dir")"
  old_n="$(page_count "$old_dir")"
  max=$new_n
  [ "$old_n" -gt "$max" ] && max=$old_n

  i=1
  while [ "$i" -le "$max" ]; do
    local old="$old_dir/p$i.png" new="$new_dir/p$i.png" status=""
    if [ -f "$old" ] && [ -f "$new" ]; then
      cmp -s "$old" "$new" || status="changed"
    elif [ -f "$new" ]; then
      status="added"
    else
      status="removed"
    fi

    if [ -n "$status" ]; then
      mkdir -p "$DIFF_DIR"
      [ -f "$old" ] && cp "$old" "$DIFF_DIR/$name-p$i-before.png"
      [ -f "$new" ] && cp "$new" "$DIFF_DIR/$name-p$i-after.png"
      local bands=""
      if [ "$status" = changed ]; then
        bands="$(locate_bands "$old" "$new")"
      fi
      printf '%s\t%s\t%s\t%s\n' "$name" "$i" "$status" "$bands" >>"$DIFF_LOG"
      changed="$changed $i"
    fi
    i=$((i + 1))
  done

  if [ "$new_n" != "$old_n" ]; then
    echo "  $old_n pages → $new_n pages"
  fi
  if [ -n "$changed" ]; then
    echo "  changed pages:$changed"
  else
    echo "  unchanged"
  fi

  rm -rf "$old_dir"
  mv "$new_dir" "$old_dir"
}

build_one() {
  local name="$1"
  local src="$TARGETS_DIR/$name.typ"
  if [ ! -f "$src" ]; then
    echo "error: no such target '$name' (see ./build.sh --list)" >&2
    exit 1
  fi
  mkdir -p "$OUT_DIR"
  echo "building $name → $OUT_DIR/$name.pdf"
  typst compile --root . "$src" "$OUT_DIR/$name.pdf"
  diff_pages "$name"
}

# Emit one <div class="band"> per changed region: the same page render cropped
# to those rows, before above after. Percentage padding and margins are both
# resolved against the container width, so the crop survives any zoom level.
emit_bands() {
  local name="$1" page="$2" width="$3" bands="$4" band lo hi
  local n=0
  echo '<div class="bands">'
  for band in ${bands//,/ }; do
    lo="${band%%:*}"
    hi="${band##*:}"
    n=$((n + 1))
    printf '<div class="band">\n'
    printf '  <span class="side rm">removed</span>\n'
    printf '  <div class="clip rm" style="padding-bottom:%s%%"><img src="%s-p%s-before.png" style="margin-top:-%s%%" alt=""></div>\n' \
      "$(pct $((hi - lo + 1)) "$width")" "$name" "$page" "$(pct "$lo" "$width")"
    printf '  <span class="side add">added</span>\n'
    printf '  <div class="clip add" style="padding-bottom:%s%%"><img src="%s-p%s-after.png" style="margin-top:-%s%%" alt=""></div>\n' \
      "$(pct $((hi - lo + 1)) "$width")" "$name" "$page" "$(pct "$lo" "$width")"
    printf '</div>\n'
  done
  echo '</div>'
}

# Express a pixel measurement as a percentage of the page width.
pct() {
  awk -v n="$1" -v d="$2" 'BEGIN { printf "%.4f", (n / d) * 100 }'
}

write_diff_report() {
  [ -s "$DIFF_LOG" ] || return 0
  local out="$DIFF_DIR/index.html"

  {
    cat <<'HTML_HEAD'
<!doctype html>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>build diff</title>
<style>
  :root { color-scheme: dark }
  body { margin: 0; background: #111; color: #ddd;
         font: 13px/1.5 ui-sans-serif, -apple-system, sans-serif }
  header { position: sticky; top: 0; z-index: 1; display: flex; flex-wrap: wrap;
           gap: 8px 18px; align-items: center;
           padding: 12px 20px; background: #111; border-bottom: 1px solid #333 }
  h1 { margin: 0; font-size: 13px; font-weight: 600; letter-spacing: .04em;
       text-transform: uppercase; color: #888 }
  label { cursor: pointer; user-select: none }
  input { accent-color: #6af; margin-right: 4px; vertical-align: -1px }
  .legend { display: flex; gap: 12px; align-items: center; color: #888 }
  .swatch { display: inline-block; width: 9px; height: 9px; border-radius: 2px;
            margin-right: 4px; vertical-align: 0 }
  section { padding: 20px 0 24px }
  h2 { margin: 0 0 10px; padding: 0 20px; font-size: 13px; font-weight: 600;
       color: #7ab7ff }
  h2 .tag { margin-left: 8px; padding: 1px 6px; border-radius: 3px;
            font-size: 11px; font-weight: 500; background: #2a2a2a; color: #aaa }
  .viewport { overflow-x: auto; padding: 0 20px }

  /* The changed rows, cropped out of the full-page render at native detail. */
  .bands { padding: 0 20px }
  .band { width: calc(var(--zoom) * min(100%, 1100px)); margin-bottom: 18px }
  .side { display: block; font-size: 10px; letter-spacing: .06em;
          text-transform: uppercase; padding: 2px 0 3px }
  .side.rm { color: #ff8080 }
  .side.add { color: #5ada8a }
  .clip { position: relative; width: 100%; height: 0; overflow: hidden;
          background: #fff; border-left: 3px solid }
  .clip.rm { border-color: #d81b1b }
  .clip.add { border-color: #109c3c }
  .clip img { position: absolute; top: 0; left: 0; width: 100% }

  .bands, .pageview { display: none }
  body.mode-changes .bands { display: block }
  body:not(.mode-changes) .pageview { display: block }
  /* Nothing to crop: an added or removed page, or no band data. */
  body.mode-changes .no-bands .pageview { display: block }

  /* Both renders are black ink on white paper. Each layer tints its own ink by
     lightening it against a colored backdrop, then the two layers multiply:
     ink present in both goes black, ink in only one keeps that layer's color. */
  .pair { position: relative; width: calc(var(--zoom) * min(100%, 860px));
          background: #fff; border: 1px solid #333; isolation: isolate }
  .layer { isolation: isolate }
  .layer img { display: block; width: 100%; mix-blend-mode: lighten }
  .layer.before { background: #d81b1b }
  .layer.after { position: absolute; top: 0; left: 0; width: 100%;
                 background: #109c3c; mix-blend-mode: multiply }

  /* Raw XOR of the two renders: identical pixels go black, movement glows. */
  body.mode-xor .pair { background: #000 }
  body.mode-xor .layer.before, body.mode-xor .layer.after { background: none }
  body.mode-xor .layer img { mix-blend-mode: normal }
  body.mode-xor .layer.after { mix-blend-mode: difference }
  body.mode-xor.boost .pair { filter: brightness(2.6) }

  body.mode-side .pair { display: flex; gap: 10px; background: none; border: 0;
                         width: calc(var(--zoom) * 100%) }
  body.mode-side .layer { width: calc(50% - 5px); background: none }
  body.mode-side .layer img { mix-blend-mode: normal; border: 1px solid #333 }
  body.mode-side .layer.after { position: static; mix-blend-mode: normal }

  body.mode-before .layer.after, body.mode-after .layer.before { display: none }
  body.mode-before .layer, body.mode-after .layer { background: none }
  body.mode-before .layer img, body.mode-after .layer img
    { mix-blend-mode: normal }
  body.mode-after .layer.after { position: static; mix-blend-mode: normal }

  /* A page with no counterpart has nothing to blend against. */
  .single .layer { background: none }
  .single .layer img { mix-blend-mode: normal }
  .single .layer.after { position: static; mix-blend-mode: normal }
</style>
<body class="mode-changes" style="--zoom: 1">
<header>
  <h1>build diff</h1>
  <span>
    <label><input type="radio" name="mode" value="changes" checked>changes</label>
    <label><input type="radio" name="mode" value="tint">tinted page</label>
    <label><input type="radio" name="mode" value="xor">difference</label>
    <label><input type="radio" name="mode" value="side">side by side</label>
    <label><input type="radio" name="mode" value="before">before</label>
    <label><input type="radio" name="mode" value="after">after</label>
  </span>
  <label>zoom
    <select id="zoom">
      <option value="1">fit</option>
      <option value="1.5">150%</option>
      <option value="2">200%</option>
      <option value="3">300%</option>
    </select>
  </label>
  <label><input type="checkbox" id="boost">brighten</label>
  <span class="legend">
    <span><span class="swatch" style="background:#d81b1b"></span>removed</span>
    <span><span class="swatch" style="background:#109c3c"></span>added</span>
    <span><span class="swatch" style="background:#000;outline:1px solid #444"></span>unchanged</span>
  </span>
</header>
HTML_HEAD

    local name page status band_data width bands
    while IFS=$(printf '\t') read -r name page status band_data; do
      width="${band_data%% *}"
      bands="${band_data#* }"
      [ "$band_data" = "$width" ] && bands=""

      case "$status" in
        changed)
          if [ -n "$bands" ]; then
            printf '<section><h2>%s — page %s<span class="tag">changed</span></h2>\n' \
              "$name" "$page"
            emit_bands "$name" "$page" "$width" "$bands"
          else
            printf '<section class="no-bands"><h2>%s — page %s<span class="tag">changed</span></h2>\n' \
              "$name" "$page"
          fi
          printf '<div class="pageview viewport"><div class="pair"><div class="layer before"><img src="%s-p%s-before.png" alt=""></div><div class="layer after"><img src="%s-p%s-after.png" alt=""></div></div></div></section>\n' \
            "$name" "$page" "$name" "$page"
          ;;
        added)
          printf '<section class="no-bands"><h2>%s — page %s<span class="tag">added</span></h2>\n' \
            "$name" "$page"
          printf '<div class="pageview viewport"><div class="pair single"><div class="layer after"><img src="%s-p%s-after.png" alt=""></div></div></div></section>\n' \
            "$name" "$page"
          ;;
        removed)
          printf '<section class="no-bands"><h2>%s — page %s<span class="tag">removed</span></h2>\n' \
            "$name" "$page"
          printf '<div class="pageview viewport"><div class="pair single"><div class="layer before"><img src="%s-p%s-before.png" alt=""></div></div></div></section>\n' \
            "$name" "$page"
          ;;
      esac
    done <"$DIFF_LOG"

    cat <<'HTML_FOOT'
<script>
  const body = document.body;
  const modes = ['changes', 'tint', 'xor', 'side', 'before', 'after']
    .map((m) => 'mode-' + m);
  for (const radio of document.querySelectorAll('input[name=mode]')) {
    radio.addEventListener('change', () => {
      body.classList.remove(...modes);
      body.classList.add('mode-' + radio.value);
    });
  }
  document.getElementById('zoom').addEventListener('change', (e) => {
    body.style.setProperty('--zoom', e.target.value);
  });
  document.getElementById('boost').addEventListener('change', (e) => {
    body.classList.toggle('boost', e.target.checked);
  });
</script>
HTML_FOOT
  } >"$out"

  echo "diff → $out"
  if [ "$OPEN_DIFF" = 1 ]; then
    open "$out"
  fi
}

# Nothing changed this run, so drop last run's report rather than leave it stale.
clear_stale_diff() {
  [ -s "$DIFF_LOG" ] || rm -rf "$DIFF_DIR"
}

build_all() {
  rm -rf "$DIFF_DIR"
  check_cache_ppi
  for name in $(list_targets); do
    build_one "$name"
  done
}

if [ "${1:-}" = "--open" ]; then
  OPEN_DIFF=1
  shift
fi

case "${1:-}" in
  --list)
    list_targets
    ;;
  --clean)
    rm -rf "$OUT_DIR"
    echo "removed $OUT_DIR/"
    ;;
  --publish)
    build_all
    mkdir -p "$PUBLISH_DIR"
    cp "$OUT_DIR"/*.pdf "$PUBLISH_DIR"/
    echo "published → $PUBLISH_DIR/"
    write_diff_report
    clear_stale_diff
    ;;
  --watch)
    name="${2:?usage: ./build.sh --watch <target>}"
    src="$TARGETS_DIR/$name.typ"
    [ -f "$src" ] || { echo "error: no such target '$name'" >&2; exit 1; }
    mkdir -p "$OUT_DIR"
    echo "watching $name (Ctrl-C to stop)…"
    exec typst watch --root . "$src" "$OUT_DIR/$name.pdf"
    ;;
  "")
    build_all
    echo "done → $OUT_DIR/"
    write_diff_report
    clear_stale_diff
    ;;
  *)
    rm -rf "$DIFF_DIR"
    check_cache_ppi
    build_one "$1"
    write_diff_report
    clear_stale_diff
    ;;
esac
