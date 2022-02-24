library nominatim_geocoding;

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/model/coordinate.dart';
import 'src/model/geocoding.dart';
import 'src/nominatim_provider.dart';
import 'src/nominatim_service.dart';
import 'src/nominatim_storage.dart';

export 'src/model/address.dart' show Address;
export 'src/model/coordinate.dart' show Coordinate;
export 'src/model/geocoding.dart' show Geocoding;
export 'src/nominatim_provider.dart' hide NominatimProvider;
export 'src/nominatim_service.dart' hide NominatimService;
export 'src/nominatim_storage.dart' hide NominatimStorage;

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
