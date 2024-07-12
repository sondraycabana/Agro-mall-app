import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/module/model/country.dart';
import 'app/module/views/country_page.dart';


// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }
//
// class MyApp extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isDarkMode = ref.watch(themeProvider);
//
//     return MaterialApp(
//       theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
//       home: CountryPage(),
//     );
//   }
// }


void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp(
      // theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      theme: ThemeData(
        scaffoldBackgroundColor:isDarkMode ? const Color(0xFF000F24) : Colors.white,

      ),
      home: CountryPage(),
    );
  }
}
