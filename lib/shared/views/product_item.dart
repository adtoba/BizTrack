import 'package:biz_track/shared/buttons/add_button.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/amount_parser.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomProductItem extends StatefulWidget {
  const CustomProductItem({super.key, this.image, this.productQuantity, this.productName, this.info, this.productPrice, this.onTap, this.quantity = 0});

  final String? productName;
  final String? info;
  final String? image;
  final String? productPrice;
  final VoidCallback? onTap;
  final int? quantity;
  final int? productQuantity;

  @override
  State<CustomProductItem> createState() => _CustomProductItemState();
}

class _CustomProductItemState extends State<CustomProductItem> {
  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;


    return InkWell(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            width: config.sw(120),
            height: config.sh(140),
            decoration: BoxDecoration(
              color: isDarkMode ? ColorPalette.itemDarkBg : Colors.white
            ),
            child: Column(
              children: [
                if(widget.image!.isEmpty)...[
                    Container(
                      height: config.sh(120),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(20)),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.3)
                      ),
                      child: Image.asset(
                        "empty".png,
                        fit: BoxFit.contain,
                        color: Colors.grey,
                      ),
                    ),
                  ] else ...[
                    Container(
                      height: config.sh(120),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.image!,
                          ),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ],
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: config.sh(10)),
              decoration: BoxDecoration(
                color: isDarkMode ? ColorPalette.itemDarkBg : Colors.grey,
              ),
              child: Column(
                children: [
                  Text(
                    "${widget.productName}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.regular16.copyWith(
                      fontSize: config.sp(14),
                      color: isDarkMode ? Colors.white60 : ColorPalette.textColor,
                      fontFamily: "Apercu"
                    ),
                  ),
                  const YMargin(5),
                  Text(
                    "${currency()} ${parseAmount(widget.productPrice!)}",
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.bold16.copyWith(
                      color: isDarkMode ? ColorPalette.white : ColorPalette.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(widget.quantity! >= 1)...[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.5),
                ),
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

    return InkWell(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            width: config.sw(180),
            height: config.sh(180),
            decoration: BoxDecoration(
              color: isDarkMode ? ColorPalette.itemDarkBg : Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if(widget.image!.isEmpty)...[
                  Container(
                    height: config.sh(100),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(20)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(.3)
                    ),
                    child: Image.asset(
                      "empty".png,
                      fit: BoxFit.contain,
                      color: Colors.grey,
                    ),
                  ),
                ] else ...[
                  Container(
                    height: config.sh(100),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.image!,
                        ),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ],
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
                  child: Text(
                    "${widget.productName}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.regular16.copyWith(
                      fontSize: config.sp(14),
                      color: isDarkMode ? ColorPalette.white : ColorPalette.textColor,
                      fontFamily: "Apercu"
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "${currency()} ${parseAmount(widget.productPrice!)}",
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.bold16.copyWith(
                            color: isDarkMode ? ColorPalette.white : ColorPalette.primary,
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
                ),
                if(widget.productQuantity! == 0)...[
                  const YMargin(2),
                  Text(
                    "Out of stock",
                    style: CustomTextStyle.regular12.copyWith(
                      color: Colors.red
                    ),
                  ),
                ] else ...[
                  const YMargin(2),
                  Text(
                    "${widget.productQuantity} left",
                    style: CustomTextStyle.regular12.copyWith(
                      color: Colors.green
                    ),
                  ),
                ],
                const Spacer(),
                
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
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.5),
                  borderRadius: BorderRadius.circular(10)
                ),
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
  const CustomListProductItem({super.key, this.productName, this.info, this.productPrice, this.image});

  final String? productName;
  final String? info;
  final String? image;
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
          if(widget.image != null)...[
            Container(
              height: config.sh(80),
              width: config.sw(100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: SvgPicture.asset(
                "no_image".svg,
                fit: BoxFit.cover,
              ),
            ),
          ] else ...[
            Container(
              height: config.sh(80),
              width: config.sw(100),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.image!,
                  ),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(20)
              ),
            ),
          ],
          
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