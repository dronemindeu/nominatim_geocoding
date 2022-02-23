import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nominatim_geocoding/src/model/geocoding.dart';

import 'model/coordinate.dart';

class NominatimStorage {
  static NominatimStorage get to => Get.find();

  static final GetStorage _storage =
      GetStorage('Flutter-Nominatim-Skymind-Package');
  static const String lastSent = 'LAST_SENT';
  static const String cachedData = 'CACHED_DATA';

  Future<void> clearAll() => _storage.erase();

  Future<void> updateLastSent() =>
      _storage.write(lastSent, DateTime.now().toIso8601String());

  bool isLastSentSafe() {
    String? sentTime = _storage.read<String>(lastSent);
    if (sentTime != null) {
      DateTime dateTime = DateTime.parse(sentTime);
      return dateTime.difference(DateTime.now()).inSeconds.abs() > 1;
    }
    return true;
  }

  Future<void> updateCacheData(Geocoding geocoding) {
    List? data = _storage.read<List>(cachedData);
    if (data != null) {
      if (data.length >= 20) {
        data.removeAt(0);
      }
      data.add(geocoding.toJson());
    } else {
      data = [geocoding.toJson()];
    }
    return _storage.write(cachedData, data);
  }

  Geocoding? getCachedCoordinateData(Coordinate coordinate) {
    List? datas = _storage.read<List>(cachedData);
    if (datas != null) {
      Geocoding? coding = datas.firstWhere(
        (data) => Geocoding.fromJson(data).coordinate == coordinate,
        orElse: () => null,
      );
      return coding;
    }
    return null;
  }

  Geocoding? getCachedAddressData(String cityName, int postalCode) {
    List? datas = _storage.read<List>(cachedData);
    if (datas != null) {
      Geocoding? coding;
      for (var data in datas) {
        final code = Geocoding.fromJson(data);
        if (code.address.city == cityName &&
            code.address.postalCode == postalCode) {
          coding = code;
          break;
        }
      }
      return coding;
    }
    return null;
  }
}
