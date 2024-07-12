import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agro_mall/app/constants/app_strings/app_strings.dart';
import '../../constants/app_colors/app_colors.dart';
import '../../module/model/country.dart';
import '../../module/service/Service.dart';
import '../../module/views/country_detail_page.dart';
import '../../module/views/country_page.dart';
class CountryList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    final countryData = ref.watch(countryProvider);
    final searchTerm = ref.watch(searchTermProvider);

    return Expanded(
      child: countryData.when(
        data: (countries) {
          final filteredCountries = countries
              .where((country) =>
              country.name.toLowerCase().contains(searchTerm.toLowerCase()))
              .toList();
          final groupedCountries =
          _groupCountriesByFirstLetter(filteredCountries);
          final sortedLetters = groupedCountries.keys.toList()..sort();

          return sortedLetters.isNotEmpty
              ? ListView.builder(
            itemCount: sortedLetters.length,
            itemBuilder: (context, index) {
              final letter = sortedLetters[index];
              final countriesByLetter = groupedCountries[letter]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontFamily: "Axiforma",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode ? AppColors.whiteColor: AppColors.blackColor,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: countriesByLetter.length,
                    itemBuilder: (context, index) {
                      final country = countriesByLetter[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CountryDetailPage(country: country),
                            ),
                          );
                        },
                        leading: country.flag.isNotEmpty
                            ? (country.flag.endsWith('.svg')
                            ? SvgPicture.network(
                          country.flag,
                          width: 40,
                          placeholderBuilder: (context) =>
                              CircularProgressIndicator(),
                          fit: BoxFit.contain,
                        )
                            : Image.network(
                          country.flag,
                          width: 40,
                          errorBuilder:
                              (context, error, stackTrace) {
                            if (kDebugMode) {
                              print('Image load error: $error');
                            }
                            return const Icon(Icons
                                .error); // Placeholder for image load error
                          },
                        ))
                            : const Icon(Icons
                            .error), // Placeholder for empty or null image URL
                        title: Text(
                          country.name,
                          style: TextStyle(
                              fontFamily: "Axiforma",
                              color: isDarkMode
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor),
                        ),
                        subtitle: Text(
                          country.capital.isNotEmpty
                              ? country.capital.join(', ')
                              : 'No capital',
                          style: TextStyle(
                            fontFamily: "Axiforma",
                            color:
                            isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          )
              : Center(
            child: Text(
              "No country found",
              style: TextStyle(
                color: isDarkMode ?AppColors.whiteColor : AppColors.blackColor,
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          if (kDebugMode) {
            print('Error: $error');
          }
          return const Center(
            child: Text(AppStrings.failedToLoadFilterErrorMsg),
          );
        },
      ),
    );
  }

  Map<String, List<Country>> _groupCountriesByFirstLetter(
      List<Country> countries) {
    final Map<String, List<Country>> groupedCountries = {};

    for (var country in countries) {
      final firstLetter = country.name[0].toUpperCase();
      if (!groupedCountries.containsKey(firstLetter)) {
        groupedCountries[firstLetter] = [];
      }
      groupedCountries[firstLetter]!.add(country);
    }

    return groupedCountries;
  }
}
