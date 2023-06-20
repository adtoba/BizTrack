import 'package:biz_track/shared/style/color_palette.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
  );

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorPalette.white,
      toolbarTextStyle: TextStyle(
        color: ColorPalette.primary,
        fontWeight: FontWeight.w700
      ),
      elevation: 0.0,
      centerTitle: true,
    ),
    // textTheme: GoogleFonts.montserratTextTheme(),
    scaffoldBackgroundColor: ColorPalette.white
  );
}