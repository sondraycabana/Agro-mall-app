import 'package:agro_mall/app/utils/extensions/size_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agro_mall/app/constants/asset_paths/asset_paths.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../module/model/country.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return AppBar(
      backgroundColor: isDarkMode ? AppColors.navyBlueColor : AppColors.whiteColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isDarkMode
              ? Image.asset(
            AssetPath.exploreLightLogo,
            height: 24.14,
            width: 90.49,
          )
              : Image.asset(
            AssetPath.exploreDarkLogo,
            height: 24,
            width: 98,
          ),
          10.w,
          IconButton(
            icon: Image.asset(
              isDarkMode ? AssetPath.moonIcon : AssetPath.sunIcon,
              width: 24,
              height: 24,
            ),
            onPressed: () {
              ref.read(themeProvider.notifier).state = !isDarkMode;
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
