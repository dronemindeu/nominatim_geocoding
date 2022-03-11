import 'package:get/get.dart';
import 'package:nominatim_geocoding/src/model/geocoding.dart';
import 'package:nominatim_geocoding/src/nominatim_provider.dart';

import 'model/address.dart';
import 'model/coordinate.dart';

/// [NominatimService] to response mapping and forwarding calls to [NominatimProvider].
class NominatimService {
  /// Get service object. Stictly use this getter to create object.
  static NominatimService get to => Get.find();

  /// Provider object.
  static final NominatimProvider _provider = NominatimProvider.to;

  /// Response mapping into [Geocoding] object or throw [Exception] with message on error response.
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

  /// Provider call for the forward geocoding with [address] instance of [Address] query.
  Future<Geocoding> forwardCoding(Address address) async => _responseMapping(
      await _provider.forwardRequest(address.requestStr), address.postalCode);

  /// Provider call for the reverse geocoding with [coordinate] instance of [Coordinate] query.
  Future<Geocoding> reverseCoding(Coordinate coordinate) async =>
      _responseMapping(await _provider.reverseRequest(coordinate));
}
