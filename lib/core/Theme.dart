import 'package:flutter/material.dart';

class ThemeService{

  final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 14,
      )
    ),

    fontFamily: "Cairo",
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      splashColor: Colors.red,
      backgroundColor: Colors.red,
        hoverColor: Colors.red,
      foregroundColor: Colors.red,

    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.red,
          hoverColor: Colors.red,
      splashColor: Colors.red
    )
  );


}
