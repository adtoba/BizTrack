import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CustomAuthButton extends ConsumerWidget {
  const CustomAuthButton({
    super.key, 
    this.onTap, 
    this.icon, this.text
  });

  final VoidCallback? onTap;
  final Widget? icon;
  final String? text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = SizeConfig();

    return MaterialButton(
      minWidth: double.infinity,
      height: config.sh(55),
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: ColorPalette.primary,
      child: text != null && icon != null
        ? Padding(
          padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
          child: Row(
            children: [
              icon!,
              const Spacer(),
              Text(
                text ?? "",
                style: TextStyle(
                  color: ColorPalette.white,
                  fontWeight: FontWeight.w700,
                  fontSize: config.sp(16)
                ),
              ),
              const Spacer(),
            ],
          ),
        )
        : Text(
          text ?? "",
          style: TextStyle(
            color: ColorPalette.white,
            fontWeight: FontWeight.w700,
            fontSize: config.sp(16)
          ),
        )
    );
  }
}