import 'package:equatable/equatable.dart';

import 'locale.dart';

/// [Address] represents the actual location address
/// with attributes as follows:
/// [houseNumber], [road], [neighbourhood],
/// [suburb], [city], [district], [state], [postalCode],
/// [country], [countryCode], [locale].
class Address extends Equatable {
  /// [houseNumber] of the location.
  final String houseNumber;

  /// [road] name of the location.
  final String road;

  /// [neighbourhood] name of the location.
  final String neighbourhood;

  /// [suburb] name of the location.
  final String suburb;

  /// [city] name of the location.
  final String city;

  /// [district] of the location.
  final String district;

  /// [state] of the location.
  final String state;

  /// [postalCode] of the location.
  final int postalCode;

  /// [country] of the location.
  final String country;

  /// [countryCode] of the location.
  final String countryCode;

  /// [locale] of the location.
  final Locale locale;

  const Address({
    this.houseNumber = '',
    this.road = '',
    this.neighbourhood = '',
    this.suburb = '',
    required this.city,
    this.district = '',
    this.state = '',
    required this.postalCode,
    this.country = '',
    this.countryCode = '',
    this.locale = Locale.EN,
  });

  /// Create [Address] from json [Map] object.
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
      locale: json.containsKey('locale')
          ? int.tryParse(json['locale']) != null
              ? Locale.values[int.tryParse(json['locale'])!]
              : Locale.EN
          : Locale.EN,
    );
  }

  /// Json [Map] object of this [Address].
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
      'locale': locale.index.toString(),
    };
  }

  @override
  String toString() {
    return 'Address(house_number: $houseNumber, road: $road, neighbourhood: $neighbourhood, suburb: $suburb, city: $city, district: $district, state: $state, postcode: $postalCode, country: $country, country_code: $countryCode, locale: ${locale.name.toLowerCase()})';
  }

  /// Get [String] request of the this instance
  String get requestStr {
    return '$houseNumber $road $neighbourhood $suburb $city, $district $state $postalCode $country $countryCode'
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  /// Check if any of the field of this instance other than city and postal code.
  bool get checkEmpty {
    return houseNumber.isEmpty ||
        road.isEmpty ||
        neighbourhood.isEmpty ||
        suburb.isEmpty ||
        district.isEmpty ||
        state.isEmpty ||
        country.isEmpty ||
        countryCode.isEmpty;
  }

  /// Copy this [Address] with the given attributes if given not null.
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
    Locale? locale,
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
      locale: locale ?? this.locale,
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
        locale,
      ];
}
