import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String houseNumber;
  final String road;
  final String neighbourhood;
  final String suburb;
  final String city;
  final String district;
  final String state;
  final int postalCode;
  final String country;
  final String countryCode;

  const Address({
    required this.houseNumber,
    required this.road,
    required this.neighbourhood,
    required this.suburb,
    required this.city,
    required this.district,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.countryCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      houseNumber: json.containsKey('house_number') ? json['house_number'] : '',
      road: json.containsKey('road') ? json['road'] : '',
      neighbourhood:
          json.containsKey('neighbourhood') ? json['neighbourhood'] : '',
      suburb: json.containsKey('suburb') ? json['suburb'] : '',
      city: json.containsKey('city') ? json['city'] : '',
      district: json.containsKey('state_district')
          ? json['state_district']
          : json.containsKey('city_district')
              ? json['city_district']
              : '',
      state: json.containsKey('state') ? json['state'] : '',
      postalCode: json.containsKey('postcode')
          ? int.parse(json['postcode'].toString().replaceAll('.', ''))
          : 0,
      country: json.containsKey('country') ? json['country'] : '',
      countryCode: json.containsKey('country_code') ? json['country_code'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'house_number': houseNumber,
      'road': road,
      'neighbourhood': neighbourhood,
      'suburb': suburb,
      'city': city,
      'district': district,
      'state': state,
      'postcode': postalCode,
      'country': country,
      'country_code': countryCode,
    };
  }

  @override
  String toString() {
    return 'Address(house_number: $houseNumber, road: $road, neighbourhood: $neighbourhood, suburb: $suburb, city: $city, district: $district, state: $state, postcode: $postalCode, country: $country, country_code: $countryCode)';
  }

  Address copyWith({
    String? houseNumber,
    String? road,
    String? neighbourhood,
    String? suburb,
    String? city,
    String? district,
    String? state,
    int? postalCode,
    String? country,
    String? countryCode,
  }) {
    return Address(
      houseNumber: houseNumber ?? this.houseNumber,
      road: road ?? this.road,
      neighbourhood: neighbourhood ?? this.neighbourhood,
      suburb: suburb ?? this.suburb,
      city: city ?? this.city,
      district: district ?? this.district,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  List<Object?> get props => [
        houseNumber,
        road,
        neighbourhood,
        suburb,
        city,
        district,
        state,
        postalCode,
        country,
        countryCode,
      ];
}
