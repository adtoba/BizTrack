import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
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
    
    return const Scaffold(
      appBar: CustomAppBar(
        title: "Transaction History",
      )
    );
  }
}