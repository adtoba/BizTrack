import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, this.amount, this.time, this.trxRef, this.isFullyPaid});

  final String? amount;
  final String? time;
  final String? trxRef;
  final bool? isFullyPaid;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: config.sw(5), vertical: config.sh(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white
      ),
      child: ListTile(
        title: Text(
          "$amount",
          style: CustomTextStyle.bold16,
        ),
        subtitle: Text(
          "$time - $trxRef",
          style: CustomTextStyle.regular14,
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
    );
  }
}