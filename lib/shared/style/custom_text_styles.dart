import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:flutter/material.dart';


class CustomTextStyle {

  static TextStyle get regular12 => TextStyle(
    fontSize: SizeConfig().sp(12),
    color: ColorPalette.textColor
  );

  static TextStyle get regular14 => TextStyle(
    fontSize: SizeConfig().sp(14),
    color: ColorPalette.textColor
  );

  static TextStyle get regular16 => TextStyle(
    fontSize: SizeConfig().sp(16),
    color: ColorPalette.textColor
  );

  static TextStyle get bold16 => TextStyle(
    fontSize: SizeConfig().sp(16),
    color: ColorPalette.textColor,
    fontWeight: FontWeight.bold
  );
}