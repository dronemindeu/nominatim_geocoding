import 'package:equatable/equatable.dart';

class Coordinate extends Equatable {
  final num latitude;
  final num longitude;

  const Coordinate({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('lat') && json.containsKey('lon')) {
      return Coordinate(
        latitude:
            json['lat'] is String ? double.parse(json['lat']) : json['lat'],
        longitude:
            json['lon'] is String ? double.parse(json['lon']) : json['lon'],
      );
    }
    throw Exception('Json map does not have lat and lon attributes');
  }

  Map<String, dynamic> toJson() {

    return {
      'lat': '$latitude',
      'lon': '$longitude',
    };
  }

  @override
  String toString() {
    return 'Coordinate(lat: $latitude, lon: $longitude)';
  }

  Coordinate copyWith({
    num? latitude,
    num? longitude,
  }) {
    return Coordinate(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  List<Object?> get props => [latitude, longitude];
}
