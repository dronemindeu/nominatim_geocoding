import 'package:equatable/equatable.dart';

/// [Coordinate] represents the actual location
/// with attributes as follows:
/// [latitude], and [longitude].
class Coordinate extends Equatable {
  /// [latitude] for the location.
  final num latitude;

  /// [longitude] for the location.
  final num longitude;

  const Coordinate({
    required this.latitude,
    required this.longitude,
  });

  /// Create [Coordinate] with json [Map] object
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

  /// Json [Map] object of this [Coordinate].
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

  /// Copy this [Coordinate] with the given attributes if given not null.
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
