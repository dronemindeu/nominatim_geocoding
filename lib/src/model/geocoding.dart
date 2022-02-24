import 'package:equatable/equatable.dart';

import 'address.dart';
import 'coordinate.dart';

/// [Geocoding] represents the geocoding of the location
/// with attributes as follows:
/// [coordinate], and [address].
class Geocoding extends Equatable {
  /// [coordinate] for the location.
  final Coordinate coordinate;

  /// [address] for the location.
  final Address address;

  const Geocoding({
    required this.coordinate,
    required this.address,
  });

  /// Create [Geocoding] with json [Map] object
  factory Geocoding.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('lat') &&
        json.containsKey('lon') &&
        json.containsKey('address')) {
      return Geocoding(
        coordinate: Coordinate.fromJson(json),
        address: Address.fromJson(json['address']),
      );
    }
    throw Exception('Json map does not have address, lat, and lon attributes');
  }

  /// Json [Map] object of this [Geocoding].
  Map<String, dynamic> toJson() {
    return {
      ...coordinate.toJson(),
      'address': address.toJson(),
    };
  }

  @override
  String toString() {
    return 'Geocoding(coordinate: $coordinate, address: $address)';
  }

  /// Copy this [Geocoding] with the given attributes if given not null.
  Geocoding copyWith({
    Coordinate? coordinate,
    Address? address,
  }) {
    return Geocoding(
      coordinate: coordinate ?? this.coordinate,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [coordinate, address];
}
