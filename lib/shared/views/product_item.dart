import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:flutter/material.dart';

class CustomProductItem extends StatefulWidget {
  const CustomProductItem({super.key, this.productName, this.info, this.productPrice});

  final String? productName;
  final String? info;
  final String? productPrice;

  @override
  State<CustomProductItem> createState() => _CustomProductItemState();
}

class _CustomProductItemState extends State<CustomProductItem> {
  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Container(
      width: config.sw(160),
      height: config.sh(200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: config.sh(100),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          const YMargin(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
            child: Text(
              widget.productName!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyle.bold16,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.productPrice!,
                    style: CustomTextStyle.bold16.copyWith(
                      color: ColorPalette.primary
                    ),
                  ),
                ),
                const XMargin(5),
                IconButton(
                  onPressed: () {}, 
                  iconSize: 40,
                  icon: Icon(Icons.add_box, color: ColorPalette.primary)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}