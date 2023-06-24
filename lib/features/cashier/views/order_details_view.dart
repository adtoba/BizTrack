import 'package:biz_track/features/cashier/views/successful_transaction_view.dart';
import 'package:biz_track/features/customer/views/customers_view.dart';
import 'package:biz_track/shared/buttons/add_button.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/buttons/minus_button.dart';
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
                    separatorBuilder: (c, i) => Divider(
                      height: config.sh(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
                    itemCount: 3,
                    itemBuilder: (c, i) {
                      return Row(
                        children: [
                          MinusButton(
                            onPressed: () {},
                          ),
                          const XMargin(10),
                          Text(
                            "1",
                            style: CustomTextStyle.regular16,
                          ),
                          const XMargin(10),
                          AddButton(
                            onPressed: () {},
                          ),
                          const XMargin(20),
                          Expanded(
                            child: Text(
                              "Wagyu Black Paper",
                              style: CustomTextStyle.regular16
                            ),
                          ),
                          const XMargin(10),
                          Text(
                            "\$20.00",
                            style: CustomTextStyle.bold16
                          ),
                        ],
                      );
                    },
                  ),
                  Divider(
                    height: config.sh(20),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: config.sw(20)),
                    title: Text(
                      "Discount",
                      style: CustomTextStyle.regular16,
                    ),
                    dense: true,
                    trailing: Icon(Icons.arrow_forward_ios, size: config.sh(20)),
                  ),
                  Divider(
                    height: config.sh(20),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: config.sw(20)),
                    title: Text(
                      "Subtotal",
                      style: CustomTextStyle.bold16,
                    ),
                    trailing: Text(
                      "\$49.99",
                      style: CustomTextStyle.bold16,
                    ),
                    dense: true,
                  ),
                  Divider(
                    height: config.sh(30),
                  ),
                  const PaymentOptionsWidget(),
                  const YMargin(10),
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
                onTap: () {
                  push(const TransactionSuccessfulView());
                },
              )
            ],
          ),
        )
      ],
    );
  }
}

class PaymentOptionsWidget extends StatelessWidget {
  const PaymentOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        PaymentOptionItem(
          icon: Icons.money,
          title: "Cash",
        ),
        XMargin(30),
        PaymentOptionItem(
          icon: Icons.credit_card,
          title: "Credit",
        )
      ],
    );
  }
}

class PaymentOptionItem extends StatelessWidget {
  const PaymentOptionItem({super.key, this.title, this.icon});

  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(10)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorPalette.primary.withOpacity(.10)
          ),
          child: Icon(
            icon,
            size: config.sh(30),
            color: ColorPalette.primary,
          ),
        ),
        const YMargin(5),
        Text(
          "$title",
          style: CustomTextStyle.regular14,
        )
      ],
    );
  }
}