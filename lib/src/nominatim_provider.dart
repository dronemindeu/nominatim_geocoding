import 'package:get/get.dart';

import 'model/coordinate.dart';
import 'model/geocoding.dart';

class NominatimProvider extends GetConnect {
  static NominatimProvider get to => Get.find();

  static const String forwardPath = '/search';
  static const String reversePath = '/reverse';

  @override
  void onInit() {
    httpClient.baseUrl = 'https://nominatim.openstreetmap.org';
    httpClient.defaultContentType = 'application/json; charset=utf-8';
    httpClient.defaultDecoder = (data) {
      return data is Map<String, dynamic> &&
              data.containsKey('lat') &&
              data.containsKey('lon') &&
              data.containsKey('address')
          ? Geocoding.fromJson(data)
          : data is List &&
                  data[0] is Map<String, dynamic> &&
                  data[0].containsKey('lat') &&
                  data[0].containsKey('lon') &&
                  data[0].containsKey('address')
              ? Geocoding.fromJson(data[0])
              : data;
    };
    httpClient.sendUserAgent = true;
    httpClient.userAgent = 'Flutter-Nominatim-Skymind-Package';

    super.onInit();
  }

  Future<Response<dynamic>> forwardRequest(String queryAddress) => get(
        forwardPath,
        query: {
          'q': queryAddress,
          'format': 'json',
          'addressdetails': '1',
        },
      );

  Future<Response<dynamic>> reverseRequest(Coordinate coordinate) => get(
        reversePath,
        query: {
          ...coordinate.toJson(),
          'format': 'json',
          'addressdetails': '1',
        },
      );
}
