import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_application_1/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
    primaryColor: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20.0,
    ));

ThemeData darkTheme = ThemeData(
    primaryColor: defaultColor,
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: HexColor('333739'),
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20.0,
      backgroundColor: HexColor('333739'),
    ));
