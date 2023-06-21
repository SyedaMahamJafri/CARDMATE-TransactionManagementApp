
import 'package:flutter/material.dart';

import '../dark_theme_preferences.dart';

class DarkThemeProvider with ChangeNotifier{
 DarkThemePreferences darkThemePreferences = DarkThemePreferences();
  bool _darkTheme = false ;
  bool get getdarkTheme=>_darkTheme;

  set setdarkTheme (bool value){
    _darkTheme = value;
    darkThemePreferences.setDarkTheme(value);
    notifyListeners();
  }
}