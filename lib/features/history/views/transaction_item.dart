import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, this.amount, this.onTap, this.time, this.trxRef, this.isFullyPaid});

  final String? amount;
  final String? time;
  final String? trxRef;
  final bool? isFullyPaid;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(5), vertical: config.sh(10)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDarkMode ? ColorPalette.itemDarkBg : ColorPalette.white
        ),
        child: ListTile(
          title: Text(
            "$amount",
            style: CustomTextStyle.bold16.copyWith(
              color: isDarkMode ? ColorPalette.white : ColorPalette.textColor
            ),
          ),
          subtitle: Text(
            "$time - $trxRef",
            style: CustomTextStyle.regular14.copyWith(
              color: isDarkMode ? Colors.grey : ColorPalette.textColor
            ),
          ),
          trailing: Container(
            padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(10)),
            decoration: BoxDecoration(
              color: ColorPalette.primary,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Text(
              "PAID OFF",
              style: CustomTextStyle.regular14.copyWith(
                color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }
}