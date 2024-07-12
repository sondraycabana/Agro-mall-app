import 'package:agro_mall/app/constants/app_strings/app_strings.dart';
import 'package:agro_mall/app/constants/asset_paths/asset_paths.dart';
import 'package:agro_mall/app/utils/extensions/size_box_extension.dart';
import 'package:agro_mall/app/utils/widgets/search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/widgets/country_list.dart';
import '../../utils/widgets/custom_app_bar.dart';
import '../../utils/widgets/filter_modal.dart';
import '../../utils/widgets/language_selector.dart';
import 'country_detail_page.dart';
import '../model/country.dart';

final selectedLanguageProvider = StateProvider<String>((ref) => 'EN');
final selectedContinentProvider = StateProvider<List<String>>((ref) => []);
final selectedTimeZoneProvider = StateProvider<List<String>>((ref) => []);
final continentVisibilityProvider = StateProvider<bool>((ref) => false);
final timeZoneVisibilityProvider = StateProvider<bool>((ref) => false);
final searchTermProvider = StateProvider<String>((ref) => '');
//
// class CountryPage extends ConsumerWidget {
//   const CountryPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isDarkMode = ref.watch(themeProvider);
//     final countryData = ref.watch(countryProvider);
//     final selectedLanguage = ref.watch(selectedLanguageProvider);
//     final searchTerm = ref.watch(searchTermProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: isDarkMode ? Color(0xFF000F24) : Colors.white,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             isDarkMode
//                 ? Image.asset(
//                     AssetPath.exploreLightLogo,
//                     height: 24.14,
//                     width: 90.49,
//                   )
//                 : Image.asset(
//                     AssetPath.exploreDarkLogo,
//                     height: 24,
//                     width: 98,
//                   ),
//             SizedBox(
//               width: 10,
//             ),
//             IconButton(
//               icon: Image.asset(
//                 isDarkMode ? AssetPath.moonIcon : AssetPath.sunIcon,
//                 width: 24,
//                 height: 24,
//               ),
//               onPressed: () {
//                 ref.read(themeProvider.notifier).state = !isDarkMode;
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         margin: const EdgeInsets.fromLTRB(24, 20, 24, 16),
//         child: Column(
//           children: [
//             TextField(
//               onChanged: (value) =>
//                   ref.read(searchTermProvider.notifier).state = value,
//               textAlign: TextAlign.center,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: isDarkMode ? Color(0xFFFFFFFF) : Color(0xFF667085),
//                 ),
//                 hintText: AppStrings.searchText,
//                 hintStyle: TextStyle(
//                     color: isDarkMode ? Color(0xFFFFFFFF) : Color(0xFF667085)),
//                 filled: true,
//                 fillColor: isDarkMode ? Color(0xFF98A2B3) : Color(0xFFF2F4F7),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: isDarkMode ? Colors.transparent : Colors.transparent,
//                   ),
//                 ),
//
//                 contentPadding: EdgeInsets.symmetric(
//                     horizontal: 16.0,
//                     vertical: 20.0), // Adjust padding as needed
//                 enabledBorder: InputBorder
//                     .none, // Set enabledBorder to none to remove all borders
//                 focusedBorder: InputBorder
//                     .none, // Set focusedBorder to none to remove border on focus
//               ),
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(left: 10),
//                   height: 40,
//                   width: 73,
//                   decoration: BoxDecoration(
//                     border: Border.all(width: 0.8, color: Color(0xFFA9B8D4)),
//                     borderRadius: BorderRadius.all(Radius.circular(4)),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Color(0x1018280D),
//                         blurRadius: 2.0,
//                         offset: Offset(0, 1),
//                       )
//                     ],
//                     color: isDarkMode ? Color(0xFF000F24) : Color(0xFFFFFFFF),
//                   ),
//                   child: GestureDetector(
//                     onTap: () =>
//                         _showLanguageSelectionModal(context, ref, isDarkMode),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Icon(Icons.language,
//                             color: isDarkMode ? Colors.white : Colors.black),
//                         SizedBox(width: 8),
//                         Text(selectedLanguage,
//                             style: TextStyle(
//                                 color:
//                                     isDarkMode ? Colors.white : Colors.black)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(left: 5),
//                   // margin: EdgeInsets.only(right: 20),
//                   height: 40,
//                   width: 73,
//                   decoration: BoxDecoration(
//                     border: Border.all(width: 0.8, color: Color(0xFFA9B8D4)),
//                     borderRadius: BorderRadius.all(Radius.circular(4)),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Color(0x1018280D),
//                         blurRadius: 2.0,
//                         offset: Offset(0, 1),
//                       )
//                     ],
//                     color: isDarkMode ? Color(0xFF000F24) : Color(0xFFFFFFFF),
//                   ),
//                   child: GestureDetector(
//                     onTap: () => _showFilterModal(context, ref, isDarkMode),
//                     child: Row(
//                       children: [
//                         Image.asset(
//                           AssetPath.filterIcon,
//                           width: 24,
//                           height: 24,
//                           color: isDarkMode ? Colors.white : Colors.black,
//                         ),
//                         SizedBox(width: 8),
//                         Text(AppStrings.filter,
//                             style: TextStyle(
//                                 color:
//                                     isDarkMode ? Colors.white : Colors.black)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: countryData.when(
//                 data: (countries) {
//                   final filteredCountries = countries
//                       .where((country) => country.name
//                           .toLowerCase()
//                           .contains(searchTerm.toLowerCase()))
//                       .toList();
//                   final groupedCountries =
//                       _groupCountriesByFirstLetter(filteredCountries);
//                   final sortedLetters = groupedCountries.keys.toList()..sort();
//
//                   return sortedLetters.isNotEmpty
//                       ? ListView.builder(
//                           itemCount: sortedLetters.length,
//                           itemBuilder: (context, index) {
//                             final letter = sortedLetters[index];
//                             final countriesByLetter = groupedCountries[letter]!;
//
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 8.0),
//                                   child: Text(
//                                     letter,
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                       color: isDarkMode
//                                           ? Colors.white
//                                           : Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                                 ListView.builder(
//                                   shrinkWrap: true,
//                                   physics: NeverScrollableScrollPhysics(),
//                                   itemCount: countriesByLetter.length,
//                                   itemBuilder: (context, index) {
//                                     final country = countriesByLetter[index];
//                                     return ListTile(
//                                       onTap: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 CountryDetailPage(
//                                                     country: country),
//                                           ),
//                                         );
//                                       },
//                                       leading: country.flag.isNotEmpty
//                                           ? (country.flag.endsWith('.svg')
//                                               ? SvgPicture.network(
//                                                   country.flag,
//                                                   width: 40,
//                                                   placeholderBuilder: (context) =>
//                                                       CircularProgressIndicator(),
//                                                   fit: BoxFit.contain,
//                                                 )
//                                               : Image.network(
//                                                   country.flag,
//                                                   width: 40,
//                                                   errorBuilder: (context, error,
//                                                       stackTrace) {
//                                                     if (kDebugMode) {
//                                                       print(
//                                                           'Image load error: $error');
//                                                     }
//                                                     return const Icon(Icons
//                                                         .error); // Placeholder for image load error
//                                                   },
//                                                 ))
//                                           : const Icon(Icons
//                                               .error), // Placeholder for empty or null image URL
//                                       title: Text(
//                                         country.name,
//                                         style: TextStyle(
//                                             color: isDarkMode
//                                                 ? Colors.white
//                                                 : Colors.black),
//                                       ),
//                                       subtitle: Text(
//                                         country.languages.values.join(', '),
//                                         style: TextStyle(
//                                             color: isDarkMode
//                                                 ? Colors.white70
//                                                 : Colors.black87),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             );
//                           },
//                         )
//                       : const Center(
//                           child: Text(AppStrings.noCountryFoundLoaderText));
//                 },
//                 loading: () => const Center(child: CircularProgressIndicator()),
//                 error: (error, stack) {
//                   if (kDebugMode) {
//                     print('Error: $error');
//                   }
//                   return const Center(
//                       child: Text(AppStrings.failedDataLoaderText));
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showLanguageSelectionModal(
//       BuildContext context, WidgetRef ref, bool isDarkMode) {
//     final countryData = ref.watch(countryProvider);
//     final selectedLanguage = ref.watch(selectedLanguageProvider);
//
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.8,
//           decoration: BoxDecoration(
//             color: isDarkMode ? Color(0xFF000F24) : Colors.white,
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           padding: EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     AppStrings.languageText,
//                     style: TextStyle(
//                         color: isDarkMode ? Colors.white : Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.close,
//                         color: isDarkMode ? Colors.white : Colors.black),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: countryData.when(
//                   data: (countries) {
//                     final languages = _getUniqueLanguages(countries);
//
//                     return ListView.builder(
//                       itemCount: languages.length,
//                       itemBuilder: (context, index) {
//                         final language = languages[index];
//                         return ListTile(
//                           title: Text(
//                             language,
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color:
//                                     isDarkMode ? Colors.white : Colors.black),
//                           ),
//                           trailing: Radio<String>(
//                             activeColor: isDarkMode
//                                 ? Color(0xFFFFFFFF)
//                                 : Color(
//                                     0xFF001637), // This sets the color of the radio button when selected
//                             fillColor: MaterialStateProperty.resolveWith<Color>(
//                                 (Set<MaterialState> states) {
//                               if (states.contains(MaterialState.selected)) {
//                                 return isDarkMode
//                                     ? Color(0xFFFFFFFF)
//                                     : Color(
//                                         0xFF001637); // Color when the radio button is selected
//                               }
//                               return isDarkMode
//                                   ? Color(0xFFFFFFFF)
//                                   : Colors
//                                       .black; // Color when the radio button is not selected
//                             }),
//                             value: language,
//                             groupValue: selectedLanguage,
//                             onChanged: (value) {
//                               ref
//                                   .read(selectedLanguageProvider.notifier)
//                                   .state = value!;
//                               Navigator.pop(context); // Close the modal
//                             },
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   loading: () =>
//                       const Center(child: CircularProgressIndicator()),
//                   error: (error, stack) {
//                     if (kDebugMode) {
//                       print('Error: $error');
//                     }
//                     return const Center(
//                         child: Text(AppStrings.failedToLoadLanguageErrorMsg));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _showFilterModal(BuildContext context, WidgetRef ref, bool isDarkMode) {
//     final countryData = ref.watch(countryProvider);
//     final selectedContinents = ref.watch(selectedContinentProvider);
//     final selectedTimeZones = ref.watch(selectedTimeZoneProvider);
//
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             bool isContinentVisible = ref.watch(continentVisibilityProvider);
//             bool isTimeZoneVisible = ref.watch(timeZoneVisibilityProvider);
//
//             double modalHeight = (isContinentVisible || isTimeZoneVisible)
//                 ? MediaQuery.of(context).size.height * 0.8
//                 : MediaQuery.of(context).size.height * 0.3;
//
//             return AnimatedContainer(
//               duration: Duration(milliseconds: 300),
//               height: modalHeight,
//               decoration: BoxDecoration(
//                 color: isDarkMode ? Color(0xFF000F24) : Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//               ),
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 16),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           AppStrings.filter,
//                           style: TextStyle(
//                               color: isDarkMode ? Colors.white : Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.close,
//                               color: isDarkMode ? Colors.white : Colors.black),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   Flexible(
//                     child: countryData.when(
//                       data: (countries) {
//                         final continents = _getUniqueContinents(countries);
//                         final timeZones = _getUniqueTimeZones(countries);
//
//                         return ListView(
//                           children: [
//                             ListTile(
//                               title: Text(
//                                 AppStrings.continent,
//                                 style: TextStyle(
//                                     color: isDarkMode
//                                         ? Colors.white
//                                         : Colors.black,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               trailing: IconButton(
//                                 icon: Icon(
//                                     isContinentVisible
//                                         ? Icons.expand_less
//                                         : Icons.expand_more,
//                                     color: isDarkMode
//                                         ? Colors.white
//                                         : Colors.black),
//                                 onPressed: () {
//                                   setState(() {
//                                     isContinentVisible = !isContinentVisible;
//                                     ref
//                                         .read(continentVisibilityProvider
//                                             .notifier)
//                                         .state = isContinentVisible;
//                                     modalHeight = (isContinentVisible ||
//                                             isTimeZoneVisible)
//                                         ? MediaQuery.of(context).size.height *
//                                             0.8
//                                         : MediaQuery.of(context).size.height *
//                                             0.3;
//                                   });
//                                 },
//                               ),
//                             ),
//                             if (isContinentVisible)
//                               ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: continents.length,
//                                 itemBuilder: (context, index) {
//                                   final continent = continents[index];
//                                   return ListTile(
//                                     title: Text(
//                                       continent,
//                                       style: TextStyle(
//                                           color: isDarkMode
//                                               ? Colors.white
//                                               : Colors.black),
//                                     ),
//                                     trailing: Checkbox(
//                                       value: selectedContinents
//                                           .contains(continent),
//                                       activeColor: isDarkMode
//                                           ? Color(0xFFFFFFFF)
//                                           : Color(0xFF1C1917),
//                                       checkColor: isDarkMode
//                                           ? Colors.black
//                                           : Color(0xFFFFFFFF),
//                                       onChanged: (bool? value) {
//                                         final updatedList = [
//                                           ...selectedContinents
//                                         ];
//                                         if (value == true) {
//                                           updatedList.add(continent);
//                                         } else {
//                                           updatedList.remove(continent);
//                                         }
//                                         WidgetsBinding.instance
//                                             .addPostFrameCallback((_) {
//                                           ref
//                                               .read(selectedContinentProvider
//                                                   .notifier)
//                                               .state = updatedList;
//                                         });
//                                       },
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(4),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ListTile(
//                               title: Text(
//                                 AppStrings.timeZone,
//                                 style: TextStyle(
//                                     color: isDarkMode
//                                         ? Colors.white
//                                         : Colors.black,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               trailing: IconButton(
//                                 icon: Icon(
//                                     isTimeZoneVisible
//                                         ? Icons.expand_less
//                                         : Icons.expand_more,
//                                     color: isDarkMode
//                                         ? Colors.white
//                                         : Colors.black),
//                                 onPressed: () {
//                                   setState(() {
//                                     isTimeZoneVisible = !isTimeZoneVisible;
//                                     ref
//                                         .read(
//                                             timeZoneVisibilityProvider.notifier)
//                                         .state = isTimeZoneVisible;
//                                     modalHeight = (isContinentVisible ||
//                                             isTimeZoneVisible)
//                                         ? MediaQuery.of(context).size.height *
//                                             0.8
//                                         : MediaQuery.of(context).size.height *
//                                             0.3;
//                                   });
//                                 },
//                               ),
//                             ),
//                             if (isTimeZoneVisible)
//                               ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: timeZones.length,
//                                 itemBuilder: (context, index) {
//                                   final timeZone = timeZones[index];
//                                   return ListTile(
//                                     title: Text(
//                                       timeZone,
//                                       style: TextStyle(
//                                           color: isDarkMode
//                                               ? Colors.white
//                                               : Colors.black),
//                                     ),
//                                     trailing: Checkbox(
//                                       value:
//                                           selectedTimeZones.contains(timeZone),
//                                       onChanged: (bool? value) {
//                                         final updatedTimeZones = [
//                                           ...selectedTimeZones
//                                         ];
//                                         if (value == true) {
//                                           updatedTimeZones.add(timeZone);
//                                         } else {
//                                           updatedTimeZones.remove(timeZone);
//                                         }
//                                         setState(() {
//                                           ref
//                                               .read(selectedTimeZoneProvider
//                                                   .notifier)
//                                               .state = updatedTimeZones;
//                                         });
//                                       },
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(4),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                           ],
//                         );
//                       },
//                       loading: () =>
//                           const Center(child: CircularProgressIndicator()),
//                       error: (error, stack) {
//                         if (kDebugMode) {
//                           print('Error: $error');
//                         }
//                         return const Center(
//                             child: Text(AppStrings.failedToLoadFilterErrorMsg));
//                       },
//                     ),
//                   ),
//                   if (isContinentVisible || isTimeZoneVisible)
//                     Container(
//                       padding: const EdgeInsets.only(top: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               setState(() {
//                                 ref
//                                     .read(selectedContinentProvider.notifier)
//                                     .state = [];
//                                 ref
//                                     .read(selectedTimeZoneProvider.notifier)
//                                     .state = [];
//                                 isContinentVisible = false;
//                                 isTimeZoneVisible = false;
//                                 ref
//                                     .read(continentVisibilityProvider.notifier)
//                                     .state = false;
//                                 ref
//                                     .read(timeZoneVisibilityProvider.notifier)
//                                     .state = false;
//                                 modalHeight =
//                                     MediaQuery.of(context).size.height * 0.3;
//                               });
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor:
//                                   isDarkMode ? Color(0xFF000F24) : Colors.white,
//                               side: BorderSide(
//                                   color: isDarkMode
//                                       ? Color(0xFFFFFFFF)
//                                       : Color(0xFF1C1917),
//                                   width: 1),
//                               shape: const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(4),
//                                 ),
//                               ),
//                               padding: EdgeInsets.zero,
//                             ),
//                             child: SizedBox(
//                               width: 104,
//                               height: 48,
//                               child: Center(
//                                 child: Text(
//                                   AppStrings.resetButtonText,
//                                   style: TextStyle(
//                                     color: isDarkMode
//                                         ? Color(0xFFFFFFFF)
//                                         : Colors
//                                             .black, // Adjust based on isDarkMode
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFFFF6C00),
//                               padding: EdgeInsets.zero,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(4)),
//                             ),
//                             child: const SizedBox(
//                               width: 236,
//                               height: 48,
//                               child: Center(
//                                 child: Text(
//                                   AppStrings.showResultButtonText,
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 16),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Map<String, List<Country>> _groupCountriesByFirstLetter(
//       List<Country> countries) {
//     final Map<String, List<Country>> groupedCountries = {};
//
//     for (var country in countries) {
//       final firstLetter = country.name[0].toUpperCase();
//       if (!groupedCountries.containsKey(firstLetter)) {
//         groupedCountries[firstLetter] = [];
//       }
//       groupedCountries[firstLetter]!.add(country);
//     }
//
//     return groupedCountries;
//   }
//
//   List<String> _getUniqueLanguages(List<Country> countries) {
//     final languageSet = <String>{};
//
//     for (var country in countries) {
//       languageSet.addAll(country.languages.values.map((e) => e.toString()));
//     }
//
//     return languageSet.toList();
//   }
//
//   List<String> _getUniqueContinents(List<Country> countries) {
//     final continentSet = <String>{};
//
//     for (var country in countries) {
//       continentSet.addAll(country.continents.map((e) => e.toString()));
//     }
//
//     return continentSet.toList();
//   }
//
//   List<String> _getUniqueTimeZones(List<Country> countries) {
//     final timeZoneSet = <String>{};
//
//     for (var country in countries) {
//       timeZoneSet.addAll(country.timezones.map((e) => e.toString()));
//     }
//
//     return timeZoneSet.toList();
//   }
// }

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
