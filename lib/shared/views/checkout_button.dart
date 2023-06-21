import 'package:biz_track/features/cashier/views/order_details_view.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class CheckoutButton extends ConsumerWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = SizeConfig();

    return MaterialButton(
      minWidth: double.infinity,
      height: config.sh(55),
      onPressed: () {
        push(const OrderDetailsView());
      },
      color: ColorPalette.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            "cart_icon".svg
          ),
          const XMargin(5),
          Text(
            "8 Items",
            style: CustomTextStyle.bold16.copyWith(
              color: Colors.white
            ),
          ),
          const Spacer(),
          Text(
            "Total: \$89.00",
            style: CustomTextStyle.bold16.copyWith(
              color: Colors.white
            ),
          )
        ],
      ),
    );
  }
}