import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/checkout_button.dart';
import 'package:biz_track/shared/views/product_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class CashierProductsView extends ConsumerStatefulWidget {
  const CashierProductsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CashierProductsViewState();
}

class _CashierProductsViewState extends ConsumerState<CashierProductsView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(24)),
        child: Column(
          children: [
            const YMargin(20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: config.sh(10),
                  mainAxisSpacing: config.sw(10),
                  childAspectRatio: .8
                ), 
                itemBuilder: (context, index) {
                  return const CustomProductItem(
                    productName: "Salad Tuna",
                    productPrice: "\$29.99",
                  );
                },
                itemCount: 6,
              ),
            ),
            const YMargin(10),
            const CheckoutButton(),
            const YMargin(10)
          ],
        ),
      ),
    );
  }
}