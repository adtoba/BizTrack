import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:flutter/material.dart';


class CustomTextStyle {

  static TextStyle get regular16 => TextStyle(
    fontSize: SizeConfig().sp(16),
    color: ColorPalette.textColor
  );
}