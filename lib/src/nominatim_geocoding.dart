import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'model/coordinate.dart';
import 'model/geocoding.dart';
import 'nominatim_provider.dart';
import 'nominatim_service.dart';
import 'nominatim_storage.dart';

class NominatimGeocoding {
  
  static NominatimGeocoding get to => Get.find();

  static Future<void> init() async {
    await GetStorage.init('Flutter-Nominatim-Skymind-Package');
    Get.put(NominatimService());
    Get.put(NominatimStorage());
    Get.put(NominatimProvider());
    Get.put(NominatimGeocoding());
  }

  static void clearAllCache() async {
    await _storage.clearAll();
  }

  static final NominatimService _service = NominatimService.to;
  static final NominatimStorage _storage = NominatimStorage.to;

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
