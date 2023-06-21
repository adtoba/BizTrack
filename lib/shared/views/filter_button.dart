import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class FilterButton extends StatelessWidget {
  const FilterButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: config.sh(16), horizontal: config.sw(20)),
        color: Colors.white,
        child: Row(
          children: [
            SvgPicture.asset(
              "filter_icon".svg
            ),
            const XMargin(10),
            Text(
              "Filter with date & time",
              style: CustomTextStyle.regular16,
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}