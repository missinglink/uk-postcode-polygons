
# uk-postcode-polygons

A dump of the UK postcode district and area polygons from Wikipedia in KML and GeoJSON format

## Postcode areas? Districts?

See this [helpful guide](https://ideal-postcodes.co.uk/guides/uk-postcode-format) from Ideal Postcodes.

## What is this?

An export of the KML files linked from the [List of postcode districts in the United Kingdom](https://en.wikipedia.org/w/index.php?title=List_of_postcode_districts_in_the_United_Kingdom) page, also converted to GeoJSON.

Note: Each GeoJSON file represents a postcode area and contains a `FeatureCollection`, with one `Feature` per constituent postcode district.

eg: https://github.com/missinglink/uk-postcode-polygons/blob/master/geojson/E.geojson

## Dependencies

Updating the GeoJSON and KML files from Wikipedia requires `togeojson` and `geojson-rewind` ...

```
sudo npm install -g @mapbox/togeojson
sudo npm install -g @mapbox/geojson-rewind
```

or ...

```
sudo yarn global add @mapbox/togeojson
sudo yarn global add @mapbox/geojson-rewind
````

## How was this produced?

see `update.sh`.

## Can I submit a pull request?

For the _data_? no. this repo should be considered read-only, all edits must be made to Wikipedia directly.

For the _code_? yes, please do.

## License

All data in this repository is © Wikipedia contributors, the data is available under the Creative Commons Attribution ShareAlike 3.0 Unported License.

See: https://en.wikipedia.org/wiki/Wikipedia:Copyrights
