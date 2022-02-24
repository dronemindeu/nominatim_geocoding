/// nominatim_geocoding package provides two function for forward geocoding and reverse geocoding.
/// Both functions return [Geocoding] which contains [Address] and [Coordinate].
///
/// To start using package, it needs to be initialize as follows:
/// ```dart
/// void main() async {
///   await NominatimGeocoding.init();
/// }
/// ```
///
/// Forward geocoding as follows:
/// ```dart
/// Geocoding geocoding = NominatimGeocoding.to.forwardGeoCoding(cityName as String, postalCode as int);
/// ```
///
/// Reverse geocoding as follows:
/// ```dart
/// Geocoding geocoding = NominatimGeocoding.to.reverseGeoCoding(coordinate as Coordinate);
/// ```

library nominatim_geocoding;

export 'src/model/address.dart' show Address;
export 'src/model/coordinate.dart' show Coordinate;
export 'src/model/geocoding.dart' show Geocoding;
export 'src/nominatim_geocoding.dart' show NominatimGeocoding;
