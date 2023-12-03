import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('F5F5F5'),
  //useMaterial3: true,
  fontFamily: 'Arima',
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: HexColor('F5F5F5'),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
    actionsIconTheme: IconThemeData(
      color: HexColor('#09B3AD'),
      size: 32.5,
    ),
  ),
//  floatingActionButtonTheme: FloatingActionButtonThemeData(),

  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconSize: MaterialStatePropertyAll(35),
    ),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 23,
    ),
  ),
);
