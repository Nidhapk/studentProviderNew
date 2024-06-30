import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme = ThemeData.light();
  ThemeData get thememode => currentTheme; //to access outside this class
  bool get isDarkMode => currentTheme== ThemeData.dark();
  void togglerChange() {
    currentTheme == ThemeData.dark()
        ? currentTheme = ThemeData.light()
        : currentTheme = ThemeData.dark();
    notifyListeners();
  }
}
