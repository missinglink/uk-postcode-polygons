#!/bin/bash

# sudo npm install -g togeojson
mkdir -p kml geojson;

URL="https://en.wikipedia.org/w/index.php";
BASEURL="$URL?title=List_of_postcode_districts_in_the_United_Kingdom&printable=yes";

wget -qO- $BASEURL | sed -n 's/.*href="\/wiki\/\([A-Z]*_postcode_area\).*/\1/p' | while read area;
  do
    echo "$area";
    wget -qO- "$URL?title=Template:Attached_KML/$area&action=raw" > "kml/${area%_*_*}.kml";
    togeojson "kml/${area%_*_*}.kml" > "geojson/${area%_*_*}.geojson";
  done;

# delete 0 byte files
find . -size  0 -print0 | xargs -0 rm --
