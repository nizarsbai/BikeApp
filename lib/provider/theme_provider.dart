import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isDarkModeOn) {
    themeMode = isDarkModeOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class ThemeConfig {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(255, 10, 56, 94),
    primaryColor: const Color.fromARGB(255, 10, 56, 94),
    iconTheme: const IconThemeData(color: Colors.white, opacity: 1)
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color.fromRGBO(228,229,241, 1),
    primaryColor: const Color.fromRGBO(228,229,241, 1),
    iconTheme: const IconThemeData(color: Color.fromRGBO(56, 182, 255, 1), opacity: 1)
  );
}