import 'package:biz_track/features/inventory/model/categories_response.dart';
import 'package:biz_track/features/inventory/model/products_response.dart';
import 'package:biz_track/shared/input/custom_search_text_field.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/error_util.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/checkout_button.dart';
import 'package:biz_track/shared/views/loading_indicator.dart';
import 'package:biz_track/shared/views/product_item.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SelectedProduct {
  SelectedProduct({this.name, this.price, this.quantity, this.availableQuantity, this.sellingPrice, this.id});

  String? name;
  String? id;
  double? price;
  double? sellingPrice;
  int? availableQuantity;
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

  bool? isSearch = false;

  final ValueNotifier<String?> _searchNotifier = ValueNotifier("");

  FocusNode searchNode = FocusNode();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(cashierDashboardViewModel).getCategories();
      ref.read(cashierDashboardViewModel).getProducts();
      // await ref.read(inventoryViewModel).getCategories();
      // final res = await ref.read(inventoryViewModel).getProducts();
      // setState(() {
      //   products = res?.products ?? [];
      //   ref.read(inventoryViewModel).populateCategories();
      // });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var inventoryProvider = ref.watch(inventoryViewModel);
    var cartProvider = ref.watch(cartViewModel);
    var cashierProvider = ref.watch(cashierDashboardViewModel);

    return LoadingOverlay(
      isLoading: inventoryProvider.busy,
      color: Colors.white,
      progressIndicator: const CustomLoadingIndicator(),
      child: Scaffold(
        backgroundColor: const Color(0xffF7F8FA),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: config.sh(55),
                  padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
                  decoration: const BoxDecoration(
                    color: Colors.white
                  ),
                  child: isSearch! 
                  ? Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: config.sh(10)),
                          child: CustomSearchTextField(
                            hint: "Search name of product",
                            focusNode: searchNode,
                            suffix: const Icon(Icons.search),
                            onChanged: (String? value) {
                              _searchNotifier.value = value;
                            },
                          ),
                        ),
                      ),
                      const XMargin(20),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isSearch = false;
                            _searchNotifier.value = "";
                          });
                        }, 
                        icon: const Icon(Icons.close),
                      )
                    ],
                  )
                  : Row(
                    children: [
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Category>(
                            items: cashierProvider.categoryItems,
                            style: CustomTextStyle.regular16,
                            hint: Text(
                              "Pick a category",
                              style: CustomTextStyle.regular16,
                            ),
                            value: cashierProvider.selectedCategory,
                            onChanged: cashierProvider.onCategoryChanged
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
                        onPressed: () {
                          setState(() {
                            searchNode.requestFocus();
                            isSearch = true;
                            _searchNotifier.value = "";
                          });
                        }, 
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
                        onPressed: () async {
                          String barCodeRes = await FlutterBarcodeScanner.scanBarcode(
                            "#000000",
                            "Cancel",
                            true,
                            ScanMode.BARCODE
                          );

                          if(barCodeRes.isNotEmpty) {
                            var searchResult = cashierProvider.products!.where((element) 
                              => element.barCode == barCodeRes).toList();

                            if(searchResult.isNotEmpty) {
                              Product product = searchResult.first;
                              _selectProduct(product);
                            }
                          }
                          
                        }, 
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
                  if(cashierProvider.products!.isEmpty && !inventoryProvider.busy)...[
                    Expanded(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                      ),
                    )
                  ],
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: config.sh(50), left: config.sw(10), right: config.sw(10)),
                          child: ValueListenableBuilder<String?>(
                            valueListenable: _searchNotifier,
                            builder: (context, value, _) {
                              if(value == "") {
                                return _buildListView(cashierProvider.products);
                              } else {
                                var results = cashierProvider.products!.where((element) 
                                  => element.name!.toLowerCase().contains(value!.toLowerCase())).toList();
                                
                                return _buildListView(results);
                              }
                              
                            }
                          )
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

  Widget _buildListView(List<Product>? products) {
    var config = SizeConfig();
    var cartProvider = ref.watch(cartViewModel);

    return Wrap(
      spacing: config.sw(10),
      runSpacing: config.sh(10),
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.center,
      children: products!.map((e) {
        return CustomProductItem(
          productName: e.name,
          productPrice: e.sellingPrice,
          image: e.image,
          productQuantity: e.stockCount,
          quantity: cartProvider.selectedProducts[e.id]?.quantity ?? 0,
          onTap: () {
            _selectProduct(e);
          },
        );
      }).toList(),
    );
  }
 
  void _selectProduct(Product e) {
    var cartProvider = ref.watch(cartViewModel);
    if(cartProvider.selectedProducts.containsKey(e.id)) {
      if(e.stockCount! != 0 && cartProvider.selectedProducts[e.id]!.quantity! <= e.stockCount! -1) {
        setState(() {
          cartProvider.addAllProducts({
            e.id! : SelectedProduct(
              name: cartProvider.selectedProducts[e.id]?.name,
              price: cartProvider.selectedProducts[e.id]!.price! + double.parse(e.sellingPrice!),
              quantity: cartProvider.selectedProducts[e.id]!.quantity! + 1,
              id: cartProvider.selectedProducts[e.id]!.id,
              availableQuantity: e.stockCount,
              sellingPrice: double.parse(e.sellingPrice!)
            )
          });
        });
      } else {
        ErrorUtil.showErrorSnackbar("You don't have any ${e.name} left");
      }
    } else {
      if(e.stockCount! != 0) {
        setState(() {
          cartProvider.addAllProducts({
            e.id! : SelectedProduct(
              name: e.name,
              id: e.id,
              price: double.parse(e.sellingPrice!),
              quantity: 1,
              availableQuantity: e.stockCount,
              sellingPrice: double.parse(e.sellingPrice!)
            )
          });
        }); 
      } else {
        ErrorUtil.showErrorSnackbar("You don't have any ${e.name} left");
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}