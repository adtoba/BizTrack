import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/amount_parser.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
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
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: config.sh(160),
        width: config.sw(120),
        decoration: BoxDecoration(
          color: isDarkMode ? ColorPalette.itemDarkBg :  Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image!.isEmpty 
              ? Container(
                  height: config.sh(100),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(.3)
                  ),
                  child: Image.asset(
                    "empty".png,
                    fit: BoxFit.fill,
                    color: Colors.grey,
                  ),
                )
              : Container(
                  height: config.sh(100),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        image!,
                      ),
                      fit: BoxFit.cover
                    ),
                  ),
                ),    
            const YMargin(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
              child: Center(
                child: Text(
                  "$productName",
                  maxLines: 1,
                  style: CustomTextStyle.bold16.copyWith(
                    fontSize: config.sp(14),
                    color: isDarkMode ? Colors.white : ColorPalette.textColor
                  ),
                ),
              ),
            ),
            const YMargin(10),
            Text(
              "$quantityLeft Items left",
              style: CustomTextStyle.regular14.copyWith(
                color: isDarkMode ? Colors.grey : ColorPalette.textColor
              ),
            ),
          ],
        ),
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(5)),
      decoration: BoxDecoration(
        color: isDarkMode ? ColorPalette.itemDarkBg :  Colors.white,
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
            fontSize: config.sp(14),
            color: isDarkMode ? Colors.white : ColorPalette.textColor
          ),
        ),
        subtitle: Text(
          "$quantityLeft Items left",
          style: CustomTextStyle.regular14.copyWith(
            color: isDarkMode ? Colors.grey : ColorPalette.textColor
          ),
        ),
        trailing: Text(
          "${currency()} ${parseAmount(sellingPrice)}",
          style: CustomTextStyle.regular16.copyWith(
            color: isDarkMode ? Colors.white : ColorPalette.textColor
          ),
        ),
        contentPadding: EdgeInsets.zero,
        onTap: onTap,
      ),
    ); 
  }
}