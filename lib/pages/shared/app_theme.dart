import 'package:flutter/material.dart';

class HYAppTheme {
  // 1.共有属性
  static const double bodyFontSize = 14;
  static const double smallFontSize = 16;
  static const double normalFontSize = 20;
  static const double largeFontSize = 24;
  static const double xlargeFontSize = 30;


  // 2.普通模式
  static final Color norTextColors = Colors.red;

  static final ThemeData norTheme = ThemeData(
//    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,
    accentColor: Colors.indigo,
    secondaryHeaderColor: Colors.indigo,
//    canvasColor: Colors.white,
//      brightness:Brightness.light,
//      primaryColorBrightness:Brightness.dark,
      textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: bodyFontSize,color: Colors.black87),
      headline4: TextStyle(fontSize: smallFontSize, color: Colors.black87),
      headline3: TextStyle(fontSize: normalFontSize, color: Colors.black87),
      headline2: TextStyle(fontSize: largeFontSize, color: Colors.black87),
      headline1: TextStyle(fontSize: xlargeFontSize, color: Colors.black87),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Colors.white,
      brightness: Brightness.light,
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: bodyFontSize,color: Colors.black87),
        bodyText1: TextStyle(fontSize: bodyFontSize,color: Colors.black87),
      ),
      iconTheme:IconThemeData(
          color: Colors.black,
      )
    ),

  );


  // 3.暗黑模式
  static final Color darkTextColors = Colors.green;

  static final ThemeData darkTheme = ThemeData(
      brightness:Brightness.dark,
      primarySwatch: Colors.red,
      primaryColor:Colors.red,
      accentColor:Colors.red,
//      buttonTheme:Colors.red,
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: normalFontSize, color: darkTextColors)
    ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: Colors.black26,
        brightness: Brightness.dark,
      )
  );
}