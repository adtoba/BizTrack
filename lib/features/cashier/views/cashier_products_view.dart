import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/checkout_button.dart';
import 'package:biz_track/shared/views/product_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class SelectedProduct {
  SelectedProduct({this.name, this.price, this.quantity});

  String? name;
  String? price;
  int? quantity;
}

class CashierProductsView extends ConsumerStatefulWidget {
  const CashierProductsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CashierProductsViewState();
}

class _CashierProductsViewState extends ConsumerState<CashierProductsView> {

  String selectedValue = "All Products";
  bool isGridView = true;

  List<SelectedProduct> products = [
    SelectedProduct(
      name: "Salad Tuna",
      price: "\$29.99",
      quantity: 0
    ),
    SelectedProduct(
      name: "Pizza",
      price: "\$10.99",
      quantity: 0
    ),
    SelectedProduct(
      name: "SandWich",
      price: "\$9.88",
      quantity: 0
    ),
    SelectedProduct(
      name: "Salad Tuna",
      price: "\$29.99",
      quantity: 0
    ),
  ];

  Map<String, int> selectedProducts = {};

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
                          style: CustomTextStyle.regular16,
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
                      icon: const Icon(Icons.search),
                      iconSize: config.sh(30),
                    ),
                    const XMargin(5),
                    Container(
                      height: double.infinity,
                      width: .2,
                      color: Colors.grey,
                    ),
                    const XMargin(5),
                    IconButton(
                      onPressed: () {}, 
                      icon: const Icon(Icons.qr_code_scanner),
                      iconSize: config.sh(30),
                    ),
                    const XMargin(5),
                    Container(
                      height: double.infinity,
                      width: .2,
                      color: Colors.grey,
                    ),
                    IconButton(
                      iconSize: config.sh(30),
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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: config.sh(50), left: config.sw(5), right: config.sw(5)),
                      child: Wrap(
                        spacing: config.sw(10),
                        runSpacing: config.sh(10),
                        children: products.map((e) {
                          return CustomProductItem(
                            productName: e.name,
                            productPrice: e.price,
                            quantity: selectedProducts[e.name] ?? 0,
                            onTap: () {
                              if(selectedProducts.containsKey(e.name)) {
                                setState(() {
                                  selectedProducts.addAll({
                                    e.name! : selectedProducts[e.name]! + 1
                                  });
                                });
                              } else {
                                setState(() {
                                  selectedProducts.addAll({
                                    e.name! : 1
                                  });
                                }); 
                              }

                              print(selectedProducts);
                            },
                          );
                        }).toList(),
                      ),
                    ),
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