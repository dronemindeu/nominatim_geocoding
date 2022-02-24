import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'model/coordinate.dart';
import 'model/geocoding.dart';
import 'model/address.dart';
import 'nominatim_provider.dart';
import 'nominatim_service.dart';
import 'nominatim_storage.dart';

/// [NominatimGeocoding] provides two function for forward geocoding and reverse geocoding.
/// Both functions return [Geocoding] which contains [Address] and [Coordinate].
class NominatimGeocoding {
  /// Get [NominatimGeocoding] object.
  /// Stictly: use this getter to create object.
  /// Only use this getter after initializing package as follows:
  /// ```dart
  /// void main() async {
  ///   await NominatimGeocoding.init();
  /// }
  /// ```
  static NominatimGeocoding get to => Get.find();

  /// Initialize the package before start using the package.
  static Future<void> init() async {
    await GetStorage.init('Flutter-Nominatim-Skymind-Package');
    Get.put(NominatimService());
    Get.put(NominatimStorage());
    Get.put(NominatimProvider());
    Get.put(NominatimGeocoding());
  }

  /// Clear all cache of the cache storage.
  void clearAllCache() async {
    await _storage.clearAll();
  }

  /// [NominatimService] object.
  static final NominatimService _service = NominatimService.to;

  /// [NominatimStorage] object.
  static final NominatimStorage _storage = NominatimStorage.to;

  /// Forward geocoding of the address with [cityName] and [postalCode].
  Future<Geocoding> forwardGeoCoding(String cityName, int postalCode) async {
    Geocoding? result = _storage.getCachedAddressData(cityName, postalCode);
    if (result != null) {
      return result;
    } else {
      if (_storage.isLastSentSafe()) {
        result = await _service.forwardCoding(cityName, postalCode);
        _storage.updateLastSent();
        _storage.updateCacheData(result);
        return result;
      }
      throw Exception('can not sent more than 1 request per second');
    }
  }

  /// Reverse geocoding of the address with [coordinate].
  Future<Geocoding> reverseGeoCoding(Coordinate coordinate) async {
    Geocoding? result = _storage.getCachedCoordinateData(coordinate);
    if (result != null) {
      return result;
    } else {
      if (_storage.isLastSentSafe()) {
        result = await _service.reverseCoding(coordinate);
        _storage.updateLastSent();
        _storage.updateCacheData(result);
        return result;
      }
      throw Exception('can not sent more than 1 request per second');
    }
  }
}
