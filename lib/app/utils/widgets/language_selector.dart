import 'package:agro_mall/app/constants/app_colors/app_colors.dart';
import 'package:agro_mall/app/utils/extensions/size_box_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agro_mall/app/constants/app_strings/app_strings.dart';
import '../../module/model/country.dart';
import '../../module/service/Service.dart';
import '../../module/views/country_page.dart';
import '../helper/helper_method.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    final selectedLanguage = ref.watch(selectedLanguageProvider);

    return Container(
      margin: const EdgeInsets.only(right: 110),
      padding: const EdgeInsets.only(left: 10),
      height: 40,
      width: 73,
      decoration: BoxDecoration(
        border: Border.all(
            width: 0.8, color: AppColors.languageFilterBoxContainerBorderColor),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.languageFilterBoxContainerShadowColor,
            blurRadius: 2.0,
            offset: Offset(0, 1),
          )
        ],
        color: isDarkMode ? AppColors.navyBlueColor : AppColors.whiteColor,
      ),
      child: GestureDetector(
        onTap: () => _showLanguageSelectionModal(context, ref, isDarkMode),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.language,
                color:
                    isDarkMode ? AppColors.whiteColor : AppColors.blackColor),
            8.w,
            Text(
              selectedLanguage,
              style: TextStyle(
                  fontFamily: "Axiforma",
                  color:
                      isDarkMode ? AppColors.whiteColor : AppColors.blackColor),
            )
          ],
        ),
      ),
    );
  }

  void _showLanguageSelectionModal(
      BuildContext context, WidgetRef ref, bool isDarkMode) {
    final countryData = ref.watch(countryProvider);
    final selectedLanguage = ref.watch(selectedLanguageProvider);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFF000F24) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.languageText,
                    style: TextStyle(
                        fontFamily: "Axiforma",
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.close,
                        color: isDarkMode ? Colors.white : Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Expanded(
                child: countryData.when(
                  data: (countries) {
                    final languages = getUniqueLanguages(countries);

                    return ListView.builder(
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        final language = languages[index];
                        return ListTile(
                          title: Text(
                            language,
                            style: TextStyle(
                                fontFamily: "Axiforma",
                                fontSize: 16,
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                          trailing: Radio<String>(
                            activeColor: isDarkMode
                                ? AppColors.whiteColor
                                : AppColors.radioButtonDarkColor,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return isDarkMode
                                    ? AppColors.whiteColor
                                    : AppColors.radioButtonDarkColor;
                              }
                              return isDarkMode
                                  ? AppColors.whiteColor
                                  : AppColors.radioButtonDarkColor;
                            }),
                            value: language,
                            groupValue: selectedLanguage,
                            onChanged: (value) {
                              ref
                                  .read(selectedLanguageProvider.notifier)
                                  .state = value!;
                              Navigator.pop(context); // Close the modal
                            },
                          ),
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) {
                    if (kDebugMode) {
                      print('Error: $error');
                    }
                    return const Center(
                        child: Text(AppStrings.failedToLoadLanguageErrorMsg));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
