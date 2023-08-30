import 'package:flutter/material.dart';

class ChangeThemeMode extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isDylexsia = false;

  bool get isDarkMode => _isDarkMode;
  void toggleTheme(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  bool get isDyslexia => _isDylexsia;
  void toggleDyslexia(bool value) {
    _isDylexsia = value;
    notifyListeners();
  }

  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
}
