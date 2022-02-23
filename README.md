<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Nominatim Geocoding

Flutter package to get forward and reverse geocoding.

## Features

- Automatically stores cache upto 20 requests.
- Restriction: Only 1 request per second is allowed to send.

## Steps use

Add dependency in `pubspec.yaml` file as

```yaml
nominatim_geocoding: ^0.0.1
```

### Initialize the package

```dart
void main() async {
    await NominatimGeocoding.init();
}
```

### Forward Geocoding

```dart
Geocoding geocoding = await NominatimGeocoding.to.forwardGeoCoding('$cityName', postalCode);
```

### Reverse Geocoding

```dart
Coordinate coordinate = Coordinate(latitude: 52.567898, longitude: 30.887776);
Geocoding geocoding = await NominatimGeocoding.to.reverseGeoCoding(coordinate);
```

## Additional information

- OSM Nominatim Open-Source API is used for geocoding.
- Uses `get_storage` plugin to store cache.
- `get` plugin is used for API calls.
