import 'package:agro_mall/app/constants/app_colors/app_colors.dart';
import 'package:agro_mall/app/utils/widgets/labeled_value_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/widgets/carousel.dart';
import '../model/country.dart';

class CountryDetailPage extends ConsumerWidget {
  final Country country;

  const CountryDetailPage({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? AppColors.navyBlueColor: AppColors.whiteColor,
        title: Text(country.name,
            style: TextStyle(
              fontFamily: "Axiforma",
              color: isDarkMode ? AppColors.whiteColor: AppColors.navyBlueColor,
            )),
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : AppColors.navyBlueColor,
        ),
      ),
      body:

        ListView(
          padding: const EdgeInsets.all(5),
          children: [
            SizedBox(height: 16),
            Carousel(
              images: [country.flag, country.coatOfArms],
            ),
            SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabeledValueText(
                    label: 'Region',
                    value: country.region,
                    color: isDarkMode ? Color(0xFFFFFFFF) : Colors.black,
                  ),
                  SizedBox(height: 8),
                  LabeledValueText(
                    label: 'Capital',
                    value: country.capital.join(" , "),
                    color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                  ),
                  SizedBox(height: 8),
                  LabeledValueText(
                    label: 'Continents',
                    value: country.continents.join(" , "),
                    color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                  ),
                  SizedBox(height: 8),
                  LabeledValueText(
                    label: 'Sub Region',
                    value: country.subregion,
                    color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                  ),
                  SizedBox(height: 8),
                  LabeledValueText(
                    label: 'Calling Code',
                    value: country.callingCode,
                    color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                  ),
                ],
              ),
            ),
          ],
        )

    );
  }
}
