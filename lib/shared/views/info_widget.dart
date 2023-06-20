import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({Key? key, required this.info}) : super(key: key);

  final String info;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: config.sw(40), vertical: config.sh(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorPalette.lightBlue
      ),
      child: Text(
        info,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: ColorPalette.textColor,
          fontSize: config.sp(16)
        ),
      ),
    );
  }
}