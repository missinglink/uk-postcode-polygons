#!/bin/bash

# sudo npm install -g togeojson
mkdir -p kml geojson;

URL="https://en.wikipedia.org/w/index.php";
BASEURL="$URL?title=List_of_postcode_districts_in_the_United_Kingdom&printable=yes";
USER_AGENT="PostcodeDataBot/1.0 (https://github.com/missinglink/uk-postcode-polygons)";

curl -A "$USER_AGENT" -L -s "$BASEURL" | sed -n 's/.*href="\/wiki\/\([A-Z]*_postcode_area\).*/\1/p' | sort | uniq | while read area;
  do
    if [[ $area =~ ^BF|BX|GIR ]]; then
      echo "Skipping non-geographic postcode area ${area} ..."
    elif [[ $area =~ ^GY|IM|JE ]]; then
      echo "Skipping non-UK postcode area ${area} ..."
    else
      echo "$area";
      kmlfile="kml/${area%_*_*}.kml"
      content=$(curl -A "$USER_AGENT" -L -s "$URL?title=Template:Attached_KML/$area&action=raw")
      if [[ -n "$content" ]] && echo "$content" | head -n 1 | grep -q '<?xml'; then
        printf "%s" "$content" > "${kmlfile}"
        npx togeojson "${kmlfile}" | npx geojson-rewind > "geojson/${area%_*_*}.geojson";
      else
        echo "Skipping invalid or missing KML for ${area} ...."
      fi
    fi
  done;

# delete 0 byte files
find . -size  0 -print0 | xargs -0 rm --
