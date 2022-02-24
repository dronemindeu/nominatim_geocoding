import 'package:nominatim_geocoding/nominatim_geocoding.dart';

void main() async {
  await NominatimGeocoding.init();

  Geocoding result = await NominatimGeocoding.to.forwardGeoCoding(
    'Braunschweig',
    38120,
  );
  print(result);

  await Future.delayed(const Duration(seconds: 2));

  result = await NominatimGeocoding.to.reverseGeoCoding(
    const Coordinate(
        latitude: 52.27429313260939, longitude: 10.523078303155874),
  );
  print(result);
}
