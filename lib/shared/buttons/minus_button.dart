import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:flutter/material.dart';


class MinusButton extends StatelessWidget {
  const MinusButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: onPressed,
      child: Container(
        height: config.sh(30),
        width: config.sw(30),
        decoration: BoxDecoration(
          color: ColorPalette.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.remove, color: Colors.white),
      ),
    );
  }
}