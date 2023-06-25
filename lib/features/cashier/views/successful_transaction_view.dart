import 'package:biz_track/features/cashier/views/cashier_dashboard_view.dart';
import 'package:biz_track/features/order/models/create_order_response.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/buttons/bordered_button.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/amount_parser.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class TransactionSuccessfulView extends StatefulWidget {
  const TransactionSuccessfulView({super.key, this.data});

  final CreateOrderResponse? data;

  @override
  State<TransactionSuccessfulView> createState() => _TransactionSuccessfulViewState();
}

class _TransactionSuccessfulViewState extends State<TransactionSuccessfulView> {
  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      backgroundColor: ColorPalette.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(30)),
        child: Column(
          children: [
            const YMargin(20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(20)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              child: Column(
                children: [
                  Lottie.asset(
                    "assets/success_check.json",
                    height: config.sh(100),
                    width: config.sw(100)
                  ),
                  const YMargin(20),
                  Text(
                    "Successful Transaction!",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: config.sp(25),
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      color: ColorPalette.primary,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const YMargin(10),
                  Text(
                    "NOTE: Don't forget to smile to your\ncustomers.",
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.regular14,
                  ),
                  const YMargin(20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: config.sw(30)),
                    padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(10)),
                    decoration: BoxDecoration(
                      color: ColorPalette.primary,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Payment Method: ${widget.data?.data?.paymentMethod?.toUpperCase()}",
                          style: CustomTextStyle.bold16.copyWith(
                            color: Colors.white
                          ),
                        ),
                        Divider(height: config.sh(20), color: Colors.white),
                        Text(
                          "Amount Paid: ${currency()} ${parseAmount(widget.data?.data?.subtotal.toString())}",
                          style: CustomTextStyle.bold16.copyWith(
                            color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                  const YMargin(20),
                  CustomBorderedButton(
                    text: "SEND RECEIPT",
                    color: const Color(0xff1A72DD),
                    onTap: () {},
                  )
                ],
              ),
            ),
            const Spacer(),
            CustomBorderedButton(
              color: Colors.white,
              text: "PRINT RECEIPT",
              onTap: () {},
            ),
            const YMargin(20),
            CustomAuthButton(
              text: "NEXT ORDER",
              color: ColorPalette.white,
              textColor: ColorPalette.primary,
              onTap: () {
                pushAndRemoveUntil(const CashierDashboardView());
              },
            ),
            const YMargin(40),
          ],
        ),
      ),
    );
  }
}