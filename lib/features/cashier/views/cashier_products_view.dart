import 'package:biz_track/features/inventory/model/categories_response.dart';
import 'package:biz_track/features/inventory/model/products_response.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/checkout_button.dart';
import 'package:biz_track/shared/views/loading_indicator.dart';
import 'package:biz_track/shared/views/product_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SelectedProduct {
  SelectedProduct({this.name, this.price, this.quantity, this.sellingPrice, this.id});

  String? name;
  String? id;
  double? price;
  double? sellingPrice;
  int? quantity;
}

class CashierProductsView extends ConsumerStatefulWidget {
  const CashierProductsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CashierProductsViewState();
}

class _CashierProductsViewState extends ConsumerState<CashierProductsView> with AutomaticKeepAliveClientMixin {

  Category? selectedCategory;
  bool isGridView = true;

  Map<String, SelectedProduct> selectedProducts = {};

  List<Product>? products = [];
  List<Category>? categories = [];


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final categoryRes = await ref.read(inventoryViewModel).getCategories();
      final res = await ref.read(inventoryViewModel).getProducts();
      setState(() {
        products = res?.products ?? [];
        categories?.add(Category(
          name: "All Products",
          id: "",
        ));
        categories?.addAll(categoryRes!.categories!);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var inventoryProvider = ref.watch(inventoryViewModel);
    var cartProvider = ref.watch(cartViewModel);

    return LoadingOverlay(
      isLoading: inventoryProvider.busy,
      color: Colors.white,
      progressIndicator: const CustomLoadingIndicator(),
      child: Scaffold(
        backgroundColor: const Color(0xffF7F8FA),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          child: DropdownButton<Category>(
                            items: dropdownItems,
                            style: CustomTextStyle.regular16,
                            hint: Text(
                              "Pick a category",
                              style: CustomTextStyle.regular16,
                            ),
                            value: selectedCategory,
                            onChanged: (value) async {
                              if(value?.name == "All Products") {
                                final res = await ref.read(inventoryViewModel).getProducts();
                                setState(() {
                                  products = res?.products ?? [];
                                });
                              } else {
                                final res = await ref.read(inventoryViewModel).getProductsByCategory(
                                  categoryId: value?.id
                                );
                                setState(() {
                                  products = res?.products ?? [];
                                });
                              }
                              setState(() {
                                selectedCategory = value!;
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
                            cartProvider.clearCart();
                          });
                        }, 
                        icon: const Icon(Icons.clear_all)
                      )
                    ],
                  ),
                ),
                const YMargin(10),
                if(isGridView)...[
                  if(products!.isEmpty && !inventoryProvider.busy)...[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "out-of-stock".png,
                            height: config.sh(100),
                            width: config.sw(100),
                          ),
                          const YMargin(10),
                          Text(
                            selectedCategory == null 
                              ? "No products found"
                              : "No products found in this category",
                            style: CustomTextStyle.regular14,
                          )
                        ],
                      ),
                    )
                  ],
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: config.sh(50), left: config.sw(5), right: config.sw(5)),
                        child: Wrap(
                          spacing: config.sw(10),
                          runSpacing: config.sh(10),
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: products!.map((e) {
                            return CustomProductItem(
                              productName: e.name,
                              productPrice: e.sellingPrice,
                              image: e.image,
                              quantity: cartProvider.selectedProducts[e.id]?.quantity ?? 0,
                              onTap: () {
                                if(cartProvider.selectedProducts.containsKey(e.id)) {
                                  setState(() {
                                    cartProvider.addAllProducts({
                                      e.id! : SelectedProduct(
                                        name: cartProvider.selectedProducts[e.id]?.name,
                                        price: cartProvider.selectedProducts[e.id]!.price! + double.parse(e.sellingPrice!),
                                        quantity: cartProvider.selectedProducts[e.id]!.quantity! + 1,
                                        id: cartProvider.selectedProducts[e.id]!.id,
                                        sellingPrice: double.parse(e.sellingPrice!)
                                      )
                                    });
                                  });
                                } else {
                                  setState(() {
                                    cartProvider.addAllProducts({
                                      e.id! : SelectedProduct(
                                        name: e.name,
                                        id: e.id,
                                        price: double.parse(e.sellingPrice!),
                                        quantity: 1,
                                        sellingPrice: double.parse(e.sellingPrice!)
                                      )
                                    });
                                  }); 
                                }
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
                
                const YMargin(30),
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
      ),
    );
  }

  List<DropdownMenuItem<Category>> get dropdownItems{
    List<DropdownMenuItem<Category>> menuItems =  categories!.map((e) {
      return DropdownMenuItem<Category>(
        value: e, 
        child: Text(e.name!),
      );
    }).toList();
    return menuItems;
  }

  @override
  bool get wantKeepAlive => true;
}