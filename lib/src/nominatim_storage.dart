import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'model/address.dart';
import 'model/coordinate.dart';
import 'model/geocoding.dart';
import 'model/locale.dart';

/// [NominatimStorage] is store cache on the store using [GetStorage].
class NominatimStorage {
  /// Get storage object. Stictly use this getter to create object.
  static NominatimStorage get to => Get.find();

  /// Constructor to initialize the storage with [int] caching number in storage.
  const NominatimStorage(this._numberCached);

  /// [GetStorage] object [_storage] with the specified container name.
  static final GetStorage _storage =
      GetStorage('Flutter-Nominatim-Skymind-Package');

  /// const [String] key [_lastSent] for the last sent request using the package.
  static const String _lastSent = 'LAST_SENT';

  /// const [String] key [_cachedData] for the cached requests.
  static const String _cachedData = 'CACHED_DATA';

  /// final [int] value [_numberCached] for the number of cached requests.
  final int _numberCached;

  /// Clear all storage.
  Future<void> clearAll() => _storage.erase();

  /// Update last sent request time.
  Future<void> updateLastSent() =>
      _storage.write(_lastSent, DateTime.now().toIso8601String());

  /// Check if it is safe to send next request.
  bool isLastSentSafe() {
    String? sentTime = _storage.read<String>(_lastSent);
    if (sentTime != null) {
      DateTime dateTime = DateTime.parse(sentTime);
      return dateTime.difference(DateTime.now()).inSeconds.abs() > 1;
    }
    return true;
  }

  /// Update cached data of geocoding request.
  Future<void> updateCacheData(Geocoding geocoding) {
    List? data = _storage.read<List>(_cachedData);
    if (data != null) {
      if (data.length >= _numberCached) {
        data.removeAt(0);
      }
      data.add(geocoding.toJson());
    } else {
      data = [geocoding.toJson()];
    }
    return _storage.write(_cachedData, data);
  }

  /// Get cached data of geocoding request based on [Coordinate].
  Geocoding? getCachedCoordinateData(
    Coordinate coordinate, {
    Locale locale = Locale.EN,
  }) {
    List? datas = _storage.read<List>(_cachedData);
    if (datas != null) {
      Geocoding? coding = datas.firstWhere(
        (data) {
          Geocoding code = Geocoding.fromJson(data);
          return code.coordinate == coordinate && code.address.locale == locale;
        },
        orElse: () => null,
      );
      return coding;
    }
    return null;
  }

  /// Get cached data of geocoding request based on [address] instance of [Address].
  Geocoding? getCachedAddressData(Address address) {
    List? datas = _storage.read<List>(_cachedData);
    if (datas != null) {
      Geocoding? coding;
      for (var data in datas) {
        final code = Geocoding.fromJson(data);
        if (code.address == address ||
            (address.checkEmpty &&
                code.address.city == address.city &&
                code.address.postalCode == address.postalCode &&
                code.address.locale == address.locale)) {
          coding = code;
          break;
        }
      }
      return coding;
    }
    return null;
  }
}
