import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/amount_parser.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    this.image = "",
    this.productName,
    this.quantityLeft,
    this.sellingPrice,
    this.onTap
  });

  final String? image;
  final String? productName;
  final int? quantityLeft;
  final String? sellingPrice;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(5)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: ListTile(
        leading: image!.isEmpty 
      ? Container(
          height: config.sh(80),
          width: config.sw(80),
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.circular(20),
            color: Colors.transparent
          ),
          child: Image.asset(
            "empty".png,
            fit: BoxFit.fitHeight,
            color: Colors.grey,
          ),
        )
      : Container(
          height: config.sh(80),
          width: config.sw(80),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                image!,
              ),
              fit: BoxFit.cover
            ),
            borderRadius: BorderRadius.circular(20)
          ),
        ),              
        title: Text(
          "$productName",
          style: CustomTextStyle.bold16.copyWith(
            fontSize: config.sp(14)
          ),
        ),
        subtitle: Text(
          "$quantityLeft Items left",
          style: CustomTextStyle.regular14,
        ),
        trailing: Text(
          "${currency()} ${parseAmount(sellingPrice)}",
          style: CustomTextStyle.regular16,
        ),
        contentPadding: EdgeInsets.zero,
        onTap: onTap,
      ),
    ); 
  }
}