import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/country.dart';

final countryProvider = FutureProvider<List<Country>>((ref) async {
  try {
    print(" before end point");
    final dio = Dio();
    final response = await dio.get("https://countryinfoapi.com/api/countries");
    print(" after end point");

    if (response.statusCode == 200) {
      print(" end point okay");
      final List<dynamic> data = response.data;
      print(data);
      return data.map((item) => Country.fromJson(item)).toList();
    } else {
      print(" error error");
      throw Exception('Failed to load country data');
    }
  } catch (e) {
    print("Caught an exception: $e");
    throw Exception('Failed to load country data');
  }
});