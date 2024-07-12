import '../../module/model/country.dart';

List<String> getUniqueLanguages(List<Country> countries) {
  final languageSet = <String>{};

  for (var country in countries) {
    languageSet.addAll(country.languages.values.map((e) => e.toString()));
  }

  return languageSet.toList();
}

List<String> getUniqueContinents(List<Country> countries) {
  final continentSet = <String>{};

  for (var country in countries) {
    continentSet.addAll(country.continents.map((e) => e.toString()));
  }

  return continentSet.toList();
}

List<String> getUniqueTimeZones(List<Country> countries) {
  final timeZoneSet = <String>{};

  for (var country in countries) {
    timeZoneSet.addAll(country.timezones.map((e) => e.toString()));
  }

  return timeZoneSet.toList();
}