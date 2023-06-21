import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CustomBorderedButton extends ConsumerWidget {
  const CustomBorderedButton({
    super.key, 
    this.onTap, 
    this.child, 
    this.text,
    this.color
  });

  final VoidCallback? onTap;
  final Widget? child;
  final String? text;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = SizeConfig();

    return MaterialButton(
      minWidth: double.infinity,
      height: config.sh(55),
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: color ?? ColorPalette.primary
        )
      ),
      child: text != null 
        ? Text(
          text ?? "",
          style: TextStyle(
            color: color ?? ColorPalette.primary,
            fontWeight: FontWeight.w700,
            fontSize: config.sp(16)
          ),
        )
        : child,
    );
  }
}