import 'package:get/get.dart';
import 'package:nominatim_geocoding/src/model/geocoding.dart';
import 'package:nominatim_geocoding/src/nominatim_provider.dart';

import 'model/coordinate.dart';

class NominatimService {
  static NominatimService get to => Get.find();

  static final NominatimProvider _provider = NominatimProvider.to;

  Geocoding _responseMapping(Response response, [int postalCode = 0]) {
    if (response.status.hasError) {
      if (response.status.isUnauthorized) {
        throw Exception('Unauthorized error');
      } else if (response.status.connectionError) {
        throw Exception('Connection error');
      } else if (response.status.isForbidden) {
        throw Exception('Forbidden error');
      } else if (response.status.isNotFound) {
        throw Exception('Not found error');
      } else {
        throw Exception('Server error');
      }
    } else {
      Geocoding result = response.body;
      if (postalCode != 0 && result.address.postalCode == 0) {
        result = result.copyWith(
          address: result.address.copyWith(
            postalCode: postalCode,
          ),
        );
      }
      return result;
    }
  }

  Future<Geocoding> forwardCoding(String cityName, int postalCode) async =>
      _responseMapping(
          await _provider.forwardRequest('$cityName, $postalCode'), postalCode);

  Future<Geocoding> reverseCoding(Coordinate coordinate) async =>
      _responseMapping(await _provider.reverseRequest(coordinate));
}
