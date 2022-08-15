//A short macro that handles switching between light and dark modes

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool currentTheme = false;

  ThemeMode get themeMode {
    if (currentTheme) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  changeTheme(bool theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", theme);
    currentTheme = theme;
    notifyListeners();
  }

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentTheme = prefs.getBool("darkMode") ?? false;
    notifyListeners();
  }
}
