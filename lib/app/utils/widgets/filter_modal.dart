import 'package:agro_mall/app/utils/extensions/size_box_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agro_mall/app/constants/app_strings/app_strings.dart';
import '../../constants/app_colors/app_colors.dart';
import '../../constants/asset_paths/asset_paths.dart';
import '../../module/model/country.dart';
import '../../module/service/Service.dart';
import '../../module/views/country_page.dart';
import '../helper/helper_method.dart';

class FilterModal extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return Container(
      padding: EdgeInsets.only(left: 5),
      height: 40,
      width: 73,
      decoration: BoxDecoration(
        border: Border.all(width: 0.8, color: AppColors.languageFilterBoxContainerBorderColor),
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.languageFilterBoxContainerShadowColor,
            blurRadius: 2.0,
            offset: Offset(0, 1),
          )
        ],
        color: isDarkMode ? AppColors.navyBlueColor: AppColors.whiteColor,
      ),
      child: GestureDetector(
        onTap: () => _showFilterModal(context, ref, isDarkMode),
        child: Row(
          children: [
            Image.asset(
              AssetPath.filterIcon,
              width: 24,
              height: 24,
              color: isDarkMode ?AppColors.whiteColor :  AppColors.blackColor,
            ),
            8.w,
            Text(AppStrings.filter,
                style: TextStyle(
                    color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor)),
          ],
        ),
      ),
    );
  }

  void _showFilterModal(BuildContext context, WidgetRef ref, bool isDarkMode) {
    final countryData = ref.watch(countryProvider);
    final selectedContinents = ref.watch(selectedContinentProvider);
    final selectedTimeZones = ref.watch(selectedTimeZoneProvider);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            bool isContinentVisible = ref.watch(continentVisibilityProvider);
            bool isTimeZoneVisible = ref.watch(timeZoneVisibilityProvider);

            double modalHeight = (isContinentVisible || isTimeZoneVisible)
                ? MediaQuery.of(context).size.height * 0.8
                : MediaQuery.of(context).size.height * 0.3;

            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: modalHeight,
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.navyBlueColor : AppColors.whiteColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.filter,
                          style: TextStyle(
                              color: isDarkMode ?AppColors.whiteColor : AppColors.blackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.close,
                              color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: countryData.when(
                      data: (countries) {
                        final continents = getUniqueContinents(countries);
                        final timeZones = getUniqueTimeZones(countries);

                        return ListView(
                          children: [
                            ListTile(
                              title: Text(
                                AppStrings.continent,
                                style: TextStyle(
                                    color: isDarkMode
                                        ?AppColors.whiteColor
                                        : AppColors.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                    isContinentVisible
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    color: isDarkMode
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor),
                                onPressed: () {
                                  setState(() {
                                    isContinentVisible = !isContinentVisible;
                                    ref
                                        .read(continentVisibilityProvider
                                        .notifier)
                                        .state = isContinentVisible;
                                    modalHeight = (isContinentVisible ||
                                        isTimeZoneVisible)
                                        ? MediaQuery.of(context).size.height *
                                        0.8
                                        : MediaQuery.of(context).size.height *
                                        0.3;
                                  });
                                },
                              ),
                            ),
                            if (isContinentVisible)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: continents.length,
                                itemBuilder: (context, index) {
                                  final continent = continents[index];
                                  return ListTile(
                                    title: Text(
                                      continent,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.whiteColor
                                              : AppColors.blackColor),
                                    ),
                                    trailing: Checkbox(
                                      value: selectedContinents
                                          .contains(continent),
                                      activeColor: isDarkMode
                                      ? AppColors.whiteColor : AppColors.buttonDarkBorderColor,
                                      checkColor: isDarkMode
                                          ?AppColors.blackColor
                                          : AppColors.whiteColor,
                                      onChanged: (bool? value) {
                                        final updatedList = [
                                          ...selectedContinents
                                        ];
                                        if (value == true) {
                                          updatedList.add(continent);
                                        } else {
                                          updatedList.remove(continent);
                                        }
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          ref
                                              .read(selectedContinentProvider
                                              .notifier)
                                              .state = updatedList;
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),


                                    ),
                                  );
                                },
                              ),
                            ListTile(
                              title: Text(
                                AppStrings.timeZone,
                                style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                    isTimeZoneVisible
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    color: isDarkMode
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor),
                                onPressed: () {
                                  setState(() {
                                    isTimeZoneVisible = !isTimeZoneVisible;
                                    ref
                                        .read(
                                        timeZoneVisibilityProvider.notifier)
                                        .state = isTimeZoneVisible;
                                    modalHeight = (isContinentVisible ||
                                        isTimeZoneVisible)
                                        ? MediaQuery.of(context).size.height *
                                        0.8
                                        : MediaQuery.of(context).size.height *
                                        0.3;
                                  });
                                },
                              ),
                            ),
                            if (isTimeZoneVisible)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: timeZones.length,
                                itemBuilder: (context, index) {
                                  final timeZone = timeZones[index];
                                  return ListTile(
                                    title: Text(
                                      timeZone,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.whiteColor
                                              :AppColors.blackColor),
                                    ),
                                    trailing: Checkbox(
                                      value:
                                      selectedTimeZones.contains(timeZone),
                                      onChanged: (bool? value) {
                                        final updatedTimeZones = [
                                          ...selectedTimeZones
                                        ];
                                        if (value == true) {
                                          updatedTimeZones.add(timeZone);
                                        } else {
                                          updatedTimeZones.remove(timeZone);
                                        }
                                        setState(() {
                                          ref
                                              .read(selectedTimeZoneProvider
                                              .notifier)
                                              .state = updatedTimeZones;
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        );
                      },
                      loading: () =>
                      const Center(child: CircularProgressIndicator()),
                      error: (error, stack) {
                        if (kDebugMode) {
                          print('Error: $error');
                        }
                        return const Center(
                            child: Text(AppStrings.failedToLoadFilterErrorMsg));
                      },
                    ),
                  ),
                  if (isContinentVisible || isTimeZoneVisible)
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                ref
                                    .read(selectedContinentProvider.notifier)
                                    .state = [];
                                ref
                                    .read(selectedTimeZoneProvider.notifier)
                                    .state = [];
                                isContinentVisible = false;
                                isTimeZoneVisible = false;
                                ref
                                    .read(continentVisibilityProvider.notifier)
                                    .state = false;
                                ref
                                    .read(timeZoneVisibilityProvider.notifier)
                                    .state = false;
                                modalHeight =
                                    MediaQuery.of(context).size.height * 0.3;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              isDarkMode ? AppColors.navyBlueColor : AppColors.whiteColor,
                              side: BorderSide(
                                  color: isDarkMode
                                      ? AppColors.whiteColor
                                      : AppColors.buttonDarkBorderColor,
                                  width: 1),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                ),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: SizedBox(
                              width: 104,
                              height: 48,
                              child: Center(
                                child: Text(
                                  AppStrings.resetButtonText,
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttonOrangeColor,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            child: const SizedBox(
                              width: 236,
                              height: 48,
                              child: Center(
                                child: Text(
                                  AppStrings.showResultButtonText,
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

}
