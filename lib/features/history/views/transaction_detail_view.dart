import 'package:biz_track/features/order/models/get_order_response.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/amount_parser.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';


class TransactionDetailView extends ConsumerStatefulWidget {
  const TransactionDetailView({super.key, this.order});

  final Data? order;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransactionDetailViewState();
}

class _TransactionDetailViewState extends ConsumerState<TransactionDetailView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;
    
    var format = DateFormat.jms();
    var time = format.format(DateTime.parse(widget.order!.createdAt!).toLocal());
    
    var dateFormat = DateFormat.yMMMEd();
    var date = dateFormat.format(DateTime.parse(widget.order!.createdAt!).toLocal());

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Transaction",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const YMargin(30),
              Row(
                children: [
                  Text(
                    "Customer :",
                    style: CustomTextStyle.regular16.copyWith(
                      color: isDarkMode ? Colors.grey : ColorPalette.textColor
                    ),
                  ),
                  const XMargin(10),
                  const Spacer(),
                  Text(
                    widget.order!.customerName!.isNotEmpty 
                      ? widget.order!.customerName!
                      : "None",
                    style: CustomTextStyle.regular16.copyWith(
                      color: isDarkMode ? Colors.white : ColorPalette.textColor
                    ),
                  )
                ],
              ),
              const YMargin(20),
              Row(
                children: [
                  Text(
                    "Transaction Ref :",
                    style: CustomTextStyle.regular16.copyWith(
                      color: isDarkMode ? Colors.grey : ColorPalette.textColor
                    ),
                  ),
                  const XMargin(10),
                  const Spacer(),
                  Text(
                    widget.order!.orderRef!,
                    style: CustomTextStyle.regular16.copyWith(
                      color: isDarkMode ? Colors.white : ColorPalette.textColor
                    ),
                  )
                ],
              ),
              const YMargin(20),
              Row(
                children: [
                  Text(
                    "Transaction Date :",
                    style: CustomTextStyle.regular16.copyWith(
                      color: isDarkMode ? Colors.grey : ColorPalette.textColor
                    ),
                  ),
                  const XMargin(10),
                  const Spacer(),
                  Text(
                    "$date, $time",
                    style: CustomTextStyle.regular16.copyWith(
                      color: isDarkMode ? Colors.white : ColorPalette.textColor
                    ),
                  )
                ],
              ),
              const YMargin(20),
              Row(
                children: [
                  Text(
                    "Payment Method : ",
                    style: CustomTextStyle.regular16.copyWith(
                      color: isDarkMode ? Colors.grey : ColorPalette.textColor
                    ),
                  ),
                  const XMargin(10),
                  const Spacer(),
                  Text(
                    "${widget.order?.paymentMethod?.toUpperCase()}",
                    style: CustomTextStyle.regular16.copyWith(
                      color: isDarkMode ? Colors.white : ColorPalette.textColor
                    ),
                  )
                ],
              ),
              const YMargin(20),
              Row(
                children: [
                  Text(
                    "Cashier : ",
                    style: CustomTextStyle.regular16.copyWith(
                      color: isDarkMode ? Colors.grey : ColorPalette.textColor
                    ),
                  ),
                  const XMargin(10),
                  const Spacer(),
                  Text(
                    "${widget.order?.cashierName}",
                    style: CustomTextStyle.regular16.copyWith(
                      color: isDarkMode ? Colors.white : ColorPalette.textColor
                    ),
                  )
                ],
              ),
              const YMargin(30),
              Divider(
                height: config.sh(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Text(
                      "Item",
                      textAlign: TextAlign.start,
                      style: CustomTextStyle.bold16.copyWith(
                        color: isDarkMode ? Colors.grey : ColorPalette.textColor
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Quantity",
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.bold16.copyWith(
                        color: isDarkMode ? Colors.grey : ColorPalette.textColor
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Total",
                      textAlign: TextAlign.end,
                      style: CustomTextStyle.bold16.copyWith(
                        color: isDarkMode ? Colors.grey : ColorPalette.textColor
                      ),
                    ),
                  ),
                ],
              ),
              const YMargin(20),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (c, i) {
                  var order = widget.order!.orders![i];

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${order.name}",
                          textAlign: TextAlign.start,
                          style: CustomTextStyle.regular14.copyWith(
                            color: isDarkMode ? Colors.white : ColorPalette.textColor
                          ),
                        ),
                      ),
                      const XMargin(10),
                      Expanded(
                        child: Text(
                          "${order.quantity}",
                          style: CustomTextStyle.regular14.copyWith(
                            color: isDarkMode ? Colors.white : ColorPalette.textColor
                          ),
                        ),
                      ),
                      const XMargin(10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          parseAmount(order.total.toString()),
                          textAlign: TextAlign.end,
                          style: CustomTextStyle.regular14.copyWith(
                            color: isDarkMode ? Colors.white : ColorPalette.textColor
                          ),
                        ),
                      ),
                    ],
                  );
                }, 
                separatorBuilder: (c, i) => Divider(
                  height: config.sh(30),
                ), 
                itemCount: widget.order!.orders!.length
              ),
              const YMargin(30)
            ],
          ),
        ),
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
                    style: CustomTextStyle.regular16.copyWith(
                      color: isDarkMode ? Colors.white : ColorPalette.textColor
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${currency()} ${parseAmount(widget.order?.subtotal!.toStringAsFixed(2))}",
                    style: CustomTextStyle.bold16.copyWith(
                      color: isDarkMode ? Colors.white : ColorPalette.textColor
                    ),
                  )
                ],
              ),
              const YMargin(10),
              Row(
                children: [
                  Text(
                    "Amount Due",
                    style: CustomTextStyle.regular16,
                  ),
                  const Spacer(),
                  Text(
                    "${currency()} ${parseAmount(widget.order?.subtotal!.toStringAsFixed(2))}",
                    style: CustomTextStyle.bold16,
                  )
                ],
              ),
              const YMargin(20),
              CustomAuthButton(
                text: "PRINT RECEIPT",
                onTap: () {},
              )
            ],
          ),
        )
      ],
    );
  }
}