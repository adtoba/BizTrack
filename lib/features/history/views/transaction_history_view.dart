import 'package:biz_track/features/history/views/transaction_item.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class TransactionHistoryView extends ConsumerStatefulWidget {
  const TransactionHistoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends ConsumerState<TransactionHistoryView> {
 
  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    
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
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              padding: EdgeInsets.symmetric(horizontal: config.sw(22), vertical: config.sh(22)),
              separatorBuilder: (context, index) => const YMargin(10),
              itemBuilder: ((context, index) {
                return const TransactionItem(
                  amount: "\$29.99",
                  time: "10:00 AM",
                  trxRef: "#TRF454324223",
                  isFullyPaid: true,
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}