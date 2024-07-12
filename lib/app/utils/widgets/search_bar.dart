import 'package:agro_mall/app/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agro_mall/app/constants/app_strings/app_strings.dart';
import '../../module/model/country.dart';
import '../../module/views/country_page.dart';

class MySearchBar extends ConsumerWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return
      TextField(
      onChanged: (value) =>
      ref.read(searchTermProvider.notifier).state = value!,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: isDarkMode ? AppColors.whiteColor : AppColors.hintDarkColor,
        ),
        hintText: AppStrings.searchText,
        hintStyle: TextStyle(
            fontFamily: "Axiforma",
            color: isDarkMode ? AppColors.whiteColor : AppColors.textFieldDarkColor),
        filled: true,
        fillColor: isDarkMode ? AppColors.hintIconDarkColor : AppColors.hintIconLightColor,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkMode ? Colors.transparent : Colors.transparent,
          ),
        ),

        contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 20.0),
        enabledBorder: InputBorder
            .none,
        focusedBorder: InputBorder
            .none,
      ),
    );



  }
}
