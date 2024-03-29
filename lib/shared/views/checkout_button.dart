import 'package:biz_track/features/cashier/views/order_details_view.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/amount_parser.dart';
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
    var cartVm = ref.watch(cartViewModel);

    return MaterialButton(
      minWidth: double.infinity,
      height: config.sh(55),
      onPressed: () {
        if(cartVm.selectedProducts.isNotEmpty) {
          push(const OrderDetailsView());
        }
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
            "${cartVm.selectedProducts.keys.length} Item(s)",
            style: CustomTextStyle.bold16.copyWith(
              color: Colors.white
            ),
          ),
          const Spacer(),
          Text(
            "Total: ${currency()} ${parseAmount(cartVm.subTotal.toStringAsFixed(2))}",
            style: CustomTextStyle.bold16.copyWith(
              color: Colors.white
            ),
          )
        ],
      ),
    );
  }
}