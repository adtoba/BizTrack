import 'package:biz_track/features/customer/views/customers_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderDetailsView extends ConsumerStatefulWidget {
  const OrderDetailsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends ConsumerState<OrderDetailsView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      backgroundColor: ColorPalette.scaffoldBg,
      appBar: const CustomAppBar(
        title: "Order Details",
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () => push(const CustomerView()),
            child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: config.sw(22), vertical: config.sh(16)),
              child: Row(
                children: [
                  Text(
                    "Customer",
                    style: CustomTextStyle.regular16,
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 20)
                ],
              ),
            ),
          ),
          const YMargin(20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (c, i) => const Divider(),
                    padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
                    itemCount: 3,
                    itemBuilder: (c, i) {
                      return ListTile(
                        leading: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: config.sw(10), 
                            vertical: config.sh(5)
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorPalette.primary
                          ),
                          child: Text(
                            "5",
                            style: CustomTextStyle.regular16.copyWith(
                              color: Colors.white
                            ),
                          ),
                        ),
                        title: Text(
                          "Wagyu Black Paper",
                          style: CustomTextStyle.regular16
                        ),
                        trailing: Text(
                          "\$20.00",
                          style: CustomTextStyle.regular16
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  
                ],
              ),
            ),
          )
        ],
      ),
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(10)),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Subtotal",
                    style: CustomTextStyle.bold16,
                  ),
                  const Spacer(),
                  Text(
                    "\$49.99",
                    style: CustomTextStyle.bold16,
                  )
                ],
              ),
              const YMargin(10),
              CustomAuthButton(
                text: "Place Order",
                onTap: () {},
              )
            ],
          ),
        )
      ],
    );
  }
}