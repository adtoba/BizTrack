import 'package:biz_track/features/history/views/transaction_detail_view.dart';
import 'package:biz_track/features/history/views/transaction_item.dart';
import 'package:biz_track/features/order/models/get_order_response.dart';
import 'package:biz_track/shared/input/custom_search_text_field.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/amount_parser.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';


class TransactionHistoryView extends ConsumerStatefulWidget {
  const TransactionHistoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends ConsumerState<TransactionHistoryView> {
  final searchController = TextEditingController();
  final ValueNotifier _searchNotifier = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var employee = ref.read(authViewModel).loginResponse?.employee;
      bool isEmployee = employee != null;
      
      ref.watch(orderViewModel).getOrders(
        isEmployee: isEmployee,
        branchId: employee?.branch
      );
    });
  }
 
  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;
    
    var orderProvider = ref.watch(orderViewModel);
    var loginProvider = ref.watch(authViewModel);
    var userBranch = loginProvider.userBranch;
    var branch = loginProvider.loginResponse?.employee != null 
      ? "${userBranch?.name}"
      : "all branches";
    
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Transaction History",
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: config.sw(20), 
              vertical: config.sh(10)
            ),
            color: isDarkMode ? Colors.transparent : Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: CustomSearchTextField(
                    controller: searchController,
                    hint: "Search by transaction reference",
                    prefix: const Icon(Icons.search),
                  ),
                ),
                const XMargin(20),
                IconButton(
                  onPressed: () {}, 
                  icon: SvgPicture.asset(
                    "filter_icon".svg,
                    color: isDarkMode ? Colors.grey : Colors.black,
                  ),
                )
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(10)),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: Text(
          //       "Showing results for $branch",
          //       style: CustomTextStyle.regular14.copyWith(
          //         fontStyle: FontStyle.normal
          //       ),
          //     ),
          //   ),
          // ),
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
              child: ValueListenableBuilder(
                valueListenable: _searchNotifier,
                builder: (context, value, _) {
                  return _buildListView(orderProvider.groupOrdersByDate);
                }
              ),
            )
          ],
          
        ],
      ),
    );
  }

  Widget _buildListView(Map<dynamic, dynamic> ordersMap) {
    final config = SizeConfig();
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return ListView.separated(
      separatorBuilder: (context, i) => const YMargin(10),
      itemCount: ordersMap.length,
      padding: EdgeInsets.symmetric(horizontal: config.sw(22), vertical: config.sh(20)),
      shrinkWrap: true,
      itemBuilder: (context, i) {
        var orders = ordersMap.values.elementAt(i);
        var keys = ordersMap.keys.toList();
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
                    style: CustomTextStyle.regular12.copyWith(
                      color: isDarkMode ? ColorPalette.white : ColorPalette.textColor
                    ),
                  ),
                ),
                Text(
                  "${currency()} ${parseAmount(total.toStringAsFixed(2))}",
                  style: CustomTextStyle.bold16.copyWith(
                    color: isDarkMode ? ColorPalette.white : ColorPalette.textColor
                  ),
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
                  trxRef: order.orderRef,
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
    );
  }
}