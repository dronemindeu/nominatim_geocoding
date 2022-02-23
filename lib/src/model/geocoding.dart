import 'package:equatable/equatable.dart';

import 'address.dart';
import 'coordinate.dart';

class Geocoding extends Equatable {
  final Coordinate coordinate;
  final Address address;

  const Geocoding({
    required this.coordinate,
    required this.address,
  });

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
