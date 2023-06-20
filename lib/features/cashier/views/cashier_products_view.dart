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

  String selectedValue = "All Products";
  bool isGridView = true;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: config.sh(55),
                padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
                decoration: const BoxDecoration(
                  color: Colors.white
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: dropdownItems,
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          }
                        ), 
                      )
                    ),
                    const XMargin(30),
                    Container(
                      height: double.infinity,
                      width: .2,
                      color: Colors.grey,
                    ),
                    IconButton(
                      onPressed: () {}, 
                      icon: const Icon(Icons.search)
                    ),
                    Container(
                      height: double.infinity,
                      width: .2,
                      color: Colors.grey,
                    ),
                    IconButton(
                      onPressed: () {}, 
                      icon: const Icon(Icons.qr_code_scanner)
                    ),
                    Container(
                      height: double.infinity,
                      width: .2,
                      color: Colors.grey,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isGridView = !isGridView;
                        });
                      }, 
                      icon: isGridView 
                        ? const Icon(Icons.list)
                        : const Icon(Icons.grid_on)
                    )
                  ],
                ),
              ),
              const YMargin(10),
              if(isGridView)...[
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.only(left: config.sw(22), right: config.sw(22), bottom: config.sw(50)),
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
              ] else ...[
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
                    itemCount: 4,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const YMargin(20),
                    itemBuilder: (c, i) {
                      return const CustomListProductItem(
                        productName: "Salad Tuna",
                        productPrice: "\$29.99",
                      );
                    },
                  ),
                )
              ],
              
              const YMargin(10),
              // const CheckoutButton(),
              // const YMargin(10)
            ],
          ),
          Positioned(
            bottom: config.sh(10),
            left: config.sw(22),
            right: config.sw(22),
            child: const CheckoutButton(),
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "All Products", child: Text("All Products")),
      const DropdownMenuItem(value: "Breakfast", child: Text("Breakfast")),
      const DropdownMenuItem(value: "Lunch", child: Text("Lunch")),
      const DropdownMenuItem(value: "Dinner", child: Text("Dinner")),
    ];
    return menuItems;
  }
}