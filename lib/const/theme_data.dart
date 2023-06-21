import 'dart:ui';

import 'package:flutter/material.dart';
//Color.fromARGB(255, 122, 39, 158)
class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
     scaffoldBackgroundColor: isDarkTheme ? Colors.black: Color.fromARGB(255, 242, 217, 235),
      primarySwatch: Colors.purple,
      primaryColor: isDarkTheme ? Colors.black :  Colors.purple.shade100,
      //accentColor: Colors.deepPurple,
      backgroundColor: isDarkTheme ? Colors.grey.shade700 : Colors.white,
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      //buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      hintColor: isDarkTheme ? Colors.black : Colors.grey.shade800,
      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      
     // textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      cardColor: isDarkTheme ? Color.fromARGB(255, 118, 116, 116) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
        backgroundColor: isDarkTheme ? Color.fromARGB(255, 163, 149, 190): Color.fromARGB(255, 138, 131, 152),

      ),
      dropdownMenuTheme: Theme.of(context).dropdownMenuTheme.copyWith(
        textStyle: TextStyle(
        color:  isDarkTheme ? Colors.black: Colors.black,
      ),
      ),
      listTileTheme: Theme.of(context).listTileTheme.copyWith(
        titleTextStyle: TextStyle(
        color:  isDarkTheme ? Color.fromARGB(255, 235, 231, 237): Colors.black,
      ),
      subtitleTextStyle: TextStyle(
        color:  isDarkTheme ? Colors.grey: Colors.black,
      ),
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
      subtitle1: TextStyle(
        color:  isDarkTheme ? Colors.grey: Colors.black,
      ),
      headline6: TextStyle(
        color:  isDarkTheme ? Colors.grey: Colors.black,
      ),
      bodyText2: TextStyle(
        color: isDarkTheme ? Colors.grey: Colors.black,
      ),
        bodyText1: TextStyle(
        color: isDarkTheme ? Colors.grey: Colors.black,
      ),
      
      )
      
    );
  }
}