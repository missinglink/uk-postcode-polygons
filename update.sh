#!/bin/bash

# sudo npm install -g togeojson
mkdir -p kml geojson;

URL="https://en.wikipedia.org/w/index.php";
BASEURL="$URL?title=List_of_postcode_districts_in_the_United_Kingdom&printable=yes";

wget -qO- $BASEURL | sed -n 's/.*href="\/wiki\/\([A-Z]*_postcode_area\).*/\1/p' | sort | uniq | while read area;
  do
    if [[ $area =~ ^BF|BX|GIR ]]; then
      echo "Skipping non-geographic postcode area ${area} ..."
    elif [[ $area =~ ^GY|IM|JE ]]; then
      echo "Skipping non-UK postcode area ${area} ..."
    else
      echo "$area";
      kmlfile="kml/${area%_*_*}.kml"
      wget -qO- "$URL?title=Template:Attached_KML/$area&action=raw" > "${kmlfile}"
      if [[ -s "${kmlfile}" ]]; then
        togeojson "${kmlfile}" > "geojson/${area%_*_*}.geojson";
      else
        echo "Skipping empty postcode area ${area} ...."
      fi
    fi
  done;

# delete 0 byte files
find . -size  0 -print0 | xargs -0 rm --
