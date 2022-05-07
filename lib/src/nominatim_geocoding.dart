import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'model/coordinate.dart';
import 'model/geocoding.dart';
import 'model/address.dart';
import 'model/locale.dart';
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
  /// [reqCacheNum] of type [int] is number of request to be cached in storage.
  /// Defaults to value 100.
  static Future<void> init({int reqCacheNum = 100}) async {
    await GetStorage.init('Flutter-Nominatim-Skymind-Package');
    Get.put(NominatimService());
    Get.put(NominatimStorage(reqCacheNum));
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

  /// Forward geocoding of the [address] type [Address].
  /// City attribute should not be empty.
  /// Postalcode must be greater than 0.
  Future<Geocoding> forwardGeoCoding(Address address) async {
    assert(address.city.isNotEmpty && address.postalCode > 0);

    Geocoding? result = _storage.getCachedAddressData(address);
    if (result != null) {
      return result;
    } else {
      if (_storage.isLastSentSafe()) {
        result = await _service.forwardCoding(address);
        _storage.updateLastSent();
        _storage.updateCacheData(result);
        return result;
      }
      throw Exception('can not sent more than 1 request per second');
    }
  }

  /// Reverse geocoding of the address with [coordinate].
  Future<Geocoding> reverseGeoCoding(
    Coordinate coordinate, {
    Locale locale = Locale.EN,
  }) async {
    Geocoding? result = _storage.getCachedCoordinateData(
      coordinate,
      locale: locale,
    );
    if (result != null) {
      return result;
    } else {
      if (_storage.isLastSentSafe()) {
        result = await _service.reverseCoding(coordinate, locale: locale);
        _storage.updateLastSent();
        _storage.updateCacheData(result);
        return result;
      }
      throw Exception('can not sent more than 1 request per second');
    }
  }
}
