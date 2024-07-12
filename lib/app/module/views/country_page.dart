import 'package:agro_mall/app/utils/extensions/size_box_extension.dart';
import 'package:agro_mall/app/utils/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/widgets/country_list.dart';
import '../../utils/widgets/custom_app_bar.dart';
import '../../utils/widgets/filter_modal.dart';
import '../../utils/widgets/language_selector.dart';
import '../model/country.dart';

final selectedLanguageProvider = StateProvider<String>((ref) => 'EN');
final selectedContinentProvider = StateProvider<List<String>>((ref) => []);
final selectedTimeZoneProvider = StateProvider<List<String>>((ref) => []);
final continentVisibilityProvider = StateProvider<bool>((ref) => false);
final timeZoneVisibilityProvider = StateProvider<bool>((ref) => false);
final searchTermProvider = StateProvider<String>((ref) => '');
class CountryPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          margin: const EdgeInsets.fromLTRB(24, 20, 24, 16),
          child: Column(
            children: [
            MySearchBar(),
              16.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  LanguageSelector(),

                  FilterModal(),
                ],
              ),
             16.h,
              CountryList(),
            ],
          ),
        ));
  }
}
