import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "out-of-stock".png,
            height: config.sh(100),
            width: config.sw(100),
          ),
          const YMargin(10),
          Text(
            text!,
            style: CustomTextStyle.regular14,
          )
        ],
      ),
    );
  }
}