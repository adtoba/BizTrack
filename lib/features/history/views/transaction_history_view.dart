import 'package:biz_track/features/history/views/transaction_detail_view.dart';
import 'package:biz_track/features/history/views/transaction_item.dart';
import 'package:biz_track/features/order/models/get_order_response.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/amount_parser.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/empty_state.dart';
import 'package:biz_track/shared/views/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';


class TransactionHistoryView extends ConsumerStatefulWidget {
  const TransactionHistoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends ConsumerState<TransactionHistoryView> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(orderViewModel).getOrders();
    });
  }
 
  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var orderProvider = ref.watch(orderViewModel);
    
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      appBar: const CustomAppBar(
        title: "Transaction History",
      ),
      body: Column(
        children: [
          FilterButton(
            onTap: () {},
          ),
          if(orderProvider.busy)...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(20)),
              child: const CircularProgressIndicator(),
            )
          ] else if(orderProvider.orders!.isEmpty)...[
            const Expanded(
              child: EmptyState(
                text: "No transactions yet",
              ),
            )
          ] else ...[
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, i) => const YMargin(10),
                itemCount: orderProvider.groupOrdersByDate.length,
                padding: EdgeInsets.symmetric(horizontal: config.sw(22), vertical: config.sh(20)),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  var orders = orderProvider.groupOrdersByDate.values.elementAt(i);
                  var keys = orderProvider.groupOrdersByDate.keys.toList();
                  int total = 0;
                  orders.forEach((e) {
                    total = (total + e.subtotal).toInt();
                  });

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              DateFormat.yMMMMd("en_US").format(
                                DateTime.parse(keys[i]).toLocal()
                              ),
                              // keys[i],
                              style: CustomTextStyle.regular12,
                            ),
                          ),
                          Text(
                            "${currency()} ${parseAmount(total.toStringAsFixed(2))}",
                            style: CustomTextStyle.bold16,
                          ),
                        ],
                      ),
                      const YMargin(10),
                      ListView.separated(
                        itemCount: orders!.length,
                        separatorBuilder: (context, index) => const YMargin(10),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          var order = orders?[index] as Data;
                          var format = DateFormat.jm();
                          var time = format.format(DateTime.parse(order.createdAt!).toLocal());

                          return TransactionItem(
                            amount: "${currency()} ${parseAmount(order.subtotal!.toStringAsFixed(2))}",
                            time: time,
                            trxRef: "#TRF454324223",
                            isFullyPaid: true,
                            onTap: () {
                              push(TransactionDetailView(
                                order: order
                              ));
                            },
                          );
                        }),
                      ),
                    ],
                  );
                }
              ),
            )
          ],
          
        ],
      ),
    );
  }
}