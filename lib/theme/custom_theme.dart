import 'package:biz_track/shared/style/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData get darkTheme {

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ColorPalette.scaffoldDarkBg,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorPalette.scaffoldDarkBg.withOpacity(.7),
        toolbarTextStyle: TextStyle(
          color: ColorPalette.white,
          fontWeight: FontWeight.w700,
          fontFamily: GoogleFonts.rubik().fontFamily,
        ),
        titleTextStyle: TextStyle(
          color: ColorPalette.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          fontFamily: GoogleFonts.rubik().fontFamily,
        ),
        iconTheme: IconThemeData(
          color: ColorPalette.white
        ),
        elevation: 10.0,
        centerTitle: true,
      ),
      textTheme: GoogleFonts.rubikTextTheme()
    );
  }

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorPalette.white,
      toolbarTextStyle: TextStyle(
        color: ColorPalette.primary,
        fontWeight: FontWeight.w700,
        fontFamily: GoogleFonts.rubik().fontFamily
      ),
      iconTheme: IconThemeData(
        color: ColorPalette.primary
      ),
      titleTextStyle: TextStyle(
        color: ColorPalette.primary,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        fontFamily: GoogleFonts.rubik().fontFamily,
      ),
      elevation: 1.0,
      centerTitle: true,
    ),
    textTheme: GoogleFonts.rubikTextTheme(),
    scaffoldBackgroundColor: const Color(0xffF7F8FA),
  );
}