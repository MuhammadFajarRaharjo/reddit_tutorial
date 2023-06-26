import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/constants.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class Pallete {
  // Colors
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color.fromRGBO(26, 39, 45, 1); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static var redColor = Colors.red.shade500;
  static var blueColor = Colors.blue.shade300;

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: drawerColor,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: drawerColor,
    ),
    primaryColor: redColor,
    colorScheme: const ColorScheme.dark(background: drawerColor),
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: whiteColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: blackColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: redColor,
    colorScheme: const ColorScheme.light(background: whiteColor),
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(Pallete.darkModeAppTheme) {
    _loadTheme();
  }

  void setTheme(ThemeMode newTheme) async {
    // Simpan nilai tema ke shared_preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (newTheme == ThemeMode.light) {
      state = Pallete.lightModeAppTheme;
    } else {
      state = Pallete.darkModeAppTheme;
    }
    prefs.setInt(
      Constants.kThemePreferenceKey,
      newTheme.index,
    );
  }

  void _loadTheme() async {
    // Baca tema dari shared_preferences saat aplikasi dimulai
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeValue = prefs.getInt(Constants.kThemePreferenceKey);
    if (themeValue == ThemeMode.light.index) {
      state = Pallete.lightModeAppTheme;
    } else {
      state = Pallete.darkModeAppTheme;
    }
  }
}
