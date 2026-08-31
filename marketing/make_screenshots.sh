#!/bin/bash
set -e
cd "$(dirname "$0")"
mkdir -p appstore

files=("Plant Lib.jpg" "Detail.PNG" "Builder.jpg" "Companion.jpg" "Journal.jpg")
h1=("Care guides for" "Know when to" "Design your" "Companion planting," "Track every")
h2=("154 plants" "plant &amp; harvest" "garden beds" "made simple" "season")
sub=("Veggies, herbs &amp; flowers — all in your pocket" "Timing &amp; care for every plant" "Lay out plots and plants in minutes" "See what grows well together" "Photos, notes &amp; progress in one place")
out=("1-plants" "2-timing" "3-builder" "4-companion" "5-journal")

for i in 0 1 2 3 4; do
  f="${files[$i]}"
  iw=$(sips -g pixelWidth "$f" | awk '/pixelWidth/{print $2}')
  ih=$(sips -g pixelHeight "$f" | awk '/pixelHeight/{print $2}')
  case "$f" in *.png|*.PNG) mime="image/png";; *) mime="image/jpeg";; esac
  b64=$(base64 -i "$f" | tr -d '\n')

  read w h x y <<EOF2
$(awk -v iw="$iw" -v ih="$ih" 'BEGIN{
  boxw=1110; boxtop=470; boxh=2286;
  s1=boxw/iw; s2=boxh/ih; s=(s1<s2)?s1:s2;
  w=int(iw*s); h=int(ih*s); x=int((1290-w)/2); y=boxtop + int((boxh-h)/2);
  print w, h, x, y;
}')
EOF2

  svg="appstore/${out[$i]}.svg"
  {
    echo "<svg width=\"1290\" height=\"2796\" viewBox=\"0 0 1290 2796\" xmlns=\"http://www.w3.org/2000/svg\">"
    echo "<defs><linearGradient id=\"bg\" x1=\"0\" y1=\"0\" x2=\"0\" y2=\"1\"><stop offset=\"0\" stop-color=\"#3c6f45\"/><stop offset=\"1\" stop-color=\"#2f4a34\"/></linearGradient>"
    echo "<clipPath id=\"clip\"><rect x=\"$x\" y=\"$y\" width=\"$w\" height=\"$h\" rx=\"46\"/></clipPath></defs>"
    echo "<rect width=\"1290\" height=\"2796\" fill=\"url(#bg)\"/>"
    echo "<text x=\"645\" y=\"148\" text-anchor=\"middle\" font-family=\"-apple-system,'Helvetica Neue',Arial,sans-serif\" font-size=\"44\" font-weight=\"700\" letter-spacing=\"1\" fill=\"#aed6b1\">Sprout Together</text>"
    echo "<text x=\"645\" y=\"288\" text-anchor=\"middle\" font-family=\"-apple-system,'Helvetica Neue',Arial,sans-serif\" font-size=\"106\" font-weight=\"800\" letter-spacing=\"-1\" fill=\"#ffffff\">${h1[$i]}</text>"
    echo "<text x=\"645\" y=\"396\" text-anchor=\"middle\" font-family=\"-apple-system,'Helvetica Neue',Arial,sans-serif\" font-size=\"106\" font-weight=\"800\" letter-spacing=\"-1\" fill=\"#ffffff\">${h2[$i]}</text>"
    echo "<text x=\"645\" y=\"456\" text-anchor=\"middle\" font-family=\"-apple-system,'Helvetica Neue',Arial,sans-serif\" font-size=\"41\" font-weight=\"500\" fill=\"#cfe7d0\">${sub[$i]}</text>"
    echo "<image href=\"data:$mime;base64,$b64\" x=\"$x\" y=\"$y\" width=\"$w\" height=\"$h\" clip-path=\"url(#clip)\" preserveAspectRatio=\"xMidYMid meet\"/>"
    echo "</svg>"
  } > "$svg"

  qlmanage -t -s 2796 -o appstore "$svg" >/dev/null 2>&1
  [ -f "appstore/${out[$i]}.svg.png" ] && mv -f "appstore/${out[$i]}.svg.png" "appstore/${out[$i]}.png"
  rm -f "$svg"
  echo "built ${out[$i]}.png (img ${w}x${h} at ${x},${y})"
done

echo "=== output dimensions ==="
for p in appstore/*.png; do
  w=$(sips -g pixelWidth "$p" | awk '/pixelWidth/{print $2}')
  h=$(sips -g pixelHeight "$p" | awk '/pixelHeight/{print $2}')
  echo "$p -> ${w}x${h}"
done
