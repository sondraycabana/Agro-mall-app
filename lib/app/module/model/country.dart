import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider<bool>((ref) => false);
class Country {
  final String name;
  final List<String> tld;
  final String cca2;
  final String ccn3;
  final String cca3;
  final String cioc;
  final String fifa;
  final bool independent;
  final String status;
  final bool unMember;
  // final Map<String, Currency> currencies;
  final String callingCode;
  final List<String> capital;
  final List<String> altSpellings;
  final String region;
  final String subregion;
  final List<String> continents;
  final Map<String, dynamic> languages;
  // final List<int> latlng;
  final bool landlocked;
  final List<String> borders;
  // final int area;
  final String flag;
  final String coatOfArms;
  // final double population;
  // final Map<String, dynamic> maps;
  // final Car car;
  final String postalCodeFormat;
  final String startOfWeek;
  final List<String> timezones;

  Country({
    required this.name,
    required this.tld,
    required this.cca2,
    required this.ccn3,
    required this.cca3,
    required this.cioc,
    required this.fifa,
    required this.independent,
    required this.status,
    required this.unMember,
    // required this.currencies,
    required this.callingCode,
    required this.capital,
    required this.altSpellings,
    required this.region,
    required this.subregion,
    required this.continents,
    required this.languages,
    // required this.latlng,
    required this.landlocked,
    required this.borders,
    // required this.area,
    required this.flag,
    required this.coatOfArms,
    // required this.population,
    // required this.maps,
    // required this.car,
    required this.postalCodeFormat,
    required this.startOfWeek,
    required this.timezones,
  });








  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] ?? '',
      tld: List<String>.from(json['tld'] ?? []),
      cca2: json['cca2'] ?? '',
      ccn3: json['ccn3'] ?? '',
      cca3: json['cca3'] ?? '',
      cioc: json['cioc'] ?? '',
      fifa: json['fifa'] ?? '',
      independent: json['independent'] ?? false,
      status: json['status'] ?? '',
      unMember: json['unMember'] ?? false,
      // currencies: (json['currencies'] as Map<String, dynamic> ?? {})
      //     .map((key, value) => MapEntry(key, Currency.fromJson(value))),
      callingCode: json['callingcode'] ?? '',
      capital: List<String>.from(json['capital'] ?? []),
      altSpellings: List<String>.from(json['altSpellings'] ?? []),
      region: json['region'] ?? '',
      subregion: json['subregion'] ?? '',
      continents: List<String>.from(json['continents'] ?? []),
      languages: (json['languages'] as Map<String, dynamic> ?? {}),
          // .map((key, value) => MapEntry(key, value.toString())),
      // latlng: (json['latlng'] as List<  int> ?? []).map((e) => e).toList(),
      landlocked: json['landlocked'] ?? false,
      borders: List<String>.from(json['borders'] ?? []),
       // area: (json['area'] ?? 0),
      flag: json['flag'] ?? '',
      coatOfArms: json['coatOfArms'] ?? '',
       // population: json['population'] != null ? json['population'].toDouble() : 0.0,
      // maps: (json['maps'] as Map<String, dynamic> ?? {})
      //     .map((key, value) => MapEntry(key, value.toString())),
      // car: json['car'] != null ? Car.fromJson(json['car'] as Map<String, dynamic>) : Car(signs: [], side: ''),
      postalCodeFormat: json['postalCodeFormat'] ?? '',
      startOfWeek: json['startOfWeek'] ?? '',
      timezones: List<String>.from(json['timezones'] ?? []),


    );
  }

}

class Currency {
  final String name;
  final String symbol;

  Currency({required this.name, required this.symbol});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      name: json['name'],
      symbol: json['symbol'],
    );
  }
}

class Car {
  final List<String> signs;
  final String side;

  Car({required this.signs, required this.side});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      signs: List<String>.from(json['signs']),
      side: json['side'],
    );
  }
}






