# Nominatim Geocoding

[![pub package](https://img.shields.io/badge/nominatim__geocoding-0.0.5-blue)](https://pub.dev/packages/nominatim_geocoding)
[![popularity](https://badges.bar/nominatim_geocoding/popularity)](https://pub.dev/packages/nominatim_geocoding/score)
[![likes](https://badges.bar/nominatim_geocoding/likes)](https://pub.dev/packages/nominatim_geocoding/score)
[![pub points](https://badges.bar/nominatim_geocoding/pub%20points)](https://pub.dev/packages/nominatim_geocoding/score)

Flutter package to get forward and reverse geocoding.

## Features

- Automatically stores cache upto 20 requests.
- Restriction: Only 1 request per second is allowed to send.

## Steps use

Add dependency in `pubspec.yaml` file as

```yaml
nominatim_geocoding: ^0.0.5
```

### Initialize the package

```dart
void main() async {
    await NominatimGeocoding.init();
}
```

### Forward Geocoding

```dart
Geocoding geocoding = await NominatimGeocoding.to.forwardGeoCoding(
    const Address(
        city: 'Braunschweig',
        postalCode: 38120,
    ),
);
```

### Reverse Geocoding

```dart
Coordinate coordinate = Coordinate(latitude: 52.567898, longitude: 30.887776);
Geocoding geocoding = await NominatimGeocoding.to.reverseGeoCoding(coordinate);
```

## Additional information

- OSM Nominatim Open-Source API [https://nominatim.org/release-docs/develop/](https://nominatim.org/release-docs/develop/) is used for geocoding.
- Uses [![pub package](https://img.shields.io/badge/get_storage-grey)](https://pub.dev/packages/get_storage) plugin to store cache.
- [![pub package](https://img.shields.io/badge/get-grey)](https://pub.dev/packages/get) plugin is used for API calls.
