import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:flutter/material.dart';


class AddButton extends StatelessWidget {
  const AddButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return InkWell(
      onTap: onPressed,
      child: Container(
        height: config.sh(30),
        width: config.sw(30),
        decoration: BoxDecoration(
          color: ColorPalette.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}