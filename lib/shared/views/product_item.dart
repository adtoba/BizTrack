import 'package:biz_track/shared/buttons/add_button.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:flutter/material.dart';

class CustomProductItem extends StatefulWidget {
  const CustomProductItem({super.key, this.productName, this.info, this.productPrice, this.onTap, this.quantity = 0});

  final String? productName;
  final String? info;
  final String? productPrice;
  final VoidCallback? onTap;
  final int? quantity;

  @override
  State<CustomProductItem> createState() => _CustomProductItemState();
}

class _CustomProductItemState extends State<CustomProductItem> {
  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return InkWell(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            width: config.sw(120),
            height: config.sh(170),
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
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/png/food.jpeg",
                      ),
                      fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                const YMargin(10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
                  child: Text(
                    "${widget.productName}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.bold16.copyWith(
                      fontSize: config.sp(14)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(5)),
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
                      // const XMargin(5),
                      // IconButton(
                      //   onPressed: () {}, 
                      //   iconSize: 40,
                      //   icon: Image.asset(
                      //     "add_icon".png,
                      //     height: config.sh(35),
                      //     width: config.sw(35),
                      //   )
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
          if(widget.quantity! >= 1)...[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                color: Colors.white.withOpacity(.5),
                alignment: Alignment.center,
                child: Text(
                  "${widget.quantity}",
                  style: CustomTextStyle.bold16.copyWith(
                    color: Colors.red,
                    fontSize: config.sp(30)
                  ),
                ),
              ),
            )
          ],
        ],
      ),
    );
  }
}


class CustomListProductItem extends StatefulWidget {
  const CustomListProductItem({super.key, this.productName, this.info, this.productPrice});

  final String? productName;
  final String? info;
  final String? productPrice;

  @override
  State<CustomListProductItem> createState() => _CustomListProductItemState();
}

class _CustomListProductItemState extends State<CustomListProductItem> {
  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Container(
      width: double.infinity,
      height: config.sh(90),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: config.sh(80),
            width: config.sw(100),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(
                  "assets/png/food.jpeg",
                ),
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          const XMargin(20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: config.sh(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.productName!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.bold16,
                  ),
                  const Spacer(),
                  Text(
                    widget.productPrice!,
                    style: CustomTextStyle.bold16.copyWith(
                      color: ColorPalette.primary
                    ),
                  ),
                ],
              ),
            ),
          ),
          const XMargin(5),
          Center(
            child: AddButton(
              onPressed: () {},
            )
          ),
          const XMargin(20)
        ],
      ),
    );
  }
}