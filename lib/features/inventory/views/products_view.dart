import 'package:biz_track/features/branch/models/get_branch_response.dart';
import 'package:biz_track/features/inventory/model/products_response.dart';
import 'package:biz_track/features/inventory/views/add_product_view.dart';
import 'package:biz_track/features/inventory/views/edit_product_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_search_text_field.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/empty_state.dart';
import 'package:biz_track/shared/views/loading_indicator.dart';
import 'package:biz_track/shared/views/products_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';


class ProductsView extends ConsumerStatefulWidget {
  const ProductsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState<ProductsView> {

  String? selectedValue = "Branch 1";

  Branch? selectedBranch;

  List<Product?> products = [];

  ValueNotifier<String?> searchNotifier = ValueNotifier("");

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var employee = ref.read(authViewModel).loginResponse?.employee;
      bool isEmployee = employee != null;

      final res = await ref.read(inventoryViewModel).getProducts(
        isEmployee: isEmployee,
        branchId: employee?.branch
      );

      if(res != null) {
        setState(() {
          products = res.products ?? [];
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var inventoryProvider = ref.watch(inventoryViewModel);
    var loginProvider = ref.watch(authViewModel);
    var userBranch = loginProvider.userBranch;
    var branch = loginProvider.loginResponse?.employee != null 
      ? "${userBranch?.name}"
      : "all branches";

    return LoadingOverlay(
      isLoading: inventoryProvider.categoryBusy,
      progressIndicator: const CustomLoadingIndicator(),
      color: Colors.black,
      child: Scaffold(
        backgroundColor: ColorPalette.scaffoldBg,
        appBar: const CustomAppBar(
          title: "Products",
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: config.sw(20), 
                vertical: config.sh(10)
              ),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: CustomSearchTextField(
                      hint: "Search product name",
                      suffix: const Icon(Icons.search),
                      onChanged: (String? value) {
                        searchNotifier.value = value;
                      },
                    ),
                  ),
                  const XMargin(20),
                  IconButton(
                    onPressed: () {}, 
                    icon: SvgPicture.asset(
                      "filter_icon".svg
                    ),
                  )
                ],
              ),
            ),
            
            if(inventoryProvider.busy)...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(20)),
                child: const CircularProgressIndicator(),
              )
            ] else if(products.isEmpty)...[
              const EmptyState(
                text: "You have not created any product yet",
              )
            ] else ...[
              Expanded(
                child: ValueListenableBuilder<String?>(
                  valueListenable: searchNotifier,
                  builder: (context, value, _) {
                    if(value == "") {
                      return ListView.separated(
                        itemCount: products.length,
                        padding: EdgeInsets.symmetric(
                          horizontal: config.sw(10), 
                          vertical: config.sh(20)
                        ),
                        separatorBuilder: (c, i) => const YMargin(10),
                        itemBuilder: (c, i) {
                          return ProductItem(
                            image: products[i]!.image,
                            productName: products[i]!.name,
                            quantityLeft: products[i]!.stockCount,
                            sellingPrice: products[i]!.sellingPrice,
                            onTap: () async {
                              final category = await inventoryProvider.getCategoryById(
                                categoryId: products[i]!.category
                              );

                              final editRes = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return EditProductView(
                                  product: products[i],
                                  category: category,
                                  canEdit: true,
                                );
                              }));

                              if (editRes != null) {
                                bool isEmployee = ref.read(authViewModel).loginResponse?.employee != null;
                                var employee = ref.read(authViewModel).loginResponse?.employee;

                                final res = await ref.read(inventoryViewModel).getProducts(
                                  isEmployee: isEmployee,
                                  branchId: employee?.branch
                                );
                                    
                                setState(() {
                                  products = res!.products!;

                                });
                              }
                            },
                          );
                        },
                      );
                    } else {
                      var results = products.where((element) 
                        => element!.name!.toLowerCase().contains(value!.toLowerCase())).toList();

                      return ListView.separated(
                        itemCount: results.length,
                        padding: EdgeInsets.symmetric(
                          horizontal: config.sw(10), 
                          vertical: config.sh(20)
                        ),
                        separatorBuilder: (c, i) => const YMargin(10),
                        itemBuilder: (c, i) {
                          return ProductItem(
                            image: results[i]!.image,
                            productName: results[i]!.name,
                            quantityLeft: results[i]!.stockCount,
                            sellingPrice: results[i]!.sellingPrice,
                            onTap: () async {
                              final category = await inventoryProvider.getCategoryById(
                                categoryId: results[i]!.category
                              );

                              final editRes = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return EditProductView(
                                  product: results[i],
                                  category: category,
                                  canEdit: true,
                                );
                              }));

                              if (editRes != null) {
                                bool isEmployee = ref.read(authViewModel).loginResponse?.employee != null;
                                var employee = ref.read(authViewModel).loginResponse?.employee;

                                final res = await ref.read(inventoryViewModel).getProducts(
                                  isEmployee: isEmployee,
                                  branchId: employee?.branch
                                );
                                    
                                setState(() {
                                  products = res!.products!;

                                });
                              }
                            },
                          );
                        },
                      );
                    }
                  },
                )
              )
            ]
            
          ],
        ),
        persistentFooterButtons: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
            child: CustomAuthButton(
              text: "Add New Product",
              onTap: () async {
                final res = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddProductView();
                }));

                if (res != null) {
                  bool isEmployee = ref.read(authViewModel).loginResponse?.employee != null;
                  var employee = ref.read(authViewModel).loginResponse?.employee;

                  final res = await ref.read(inventoryViewModel).getProducts(
                    isEmployee: isEmployee,
                    branchId: employee?.branch
                  );
                  
                  setState(() {
                    products = res!.products!;
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context, List<Product?> products) {
    var config = SizeConfig();
    var inventoryProvider = ref.watch(inventoryViewModel);
    var productsList = products;

    return ListView.separated(
      itemCount: productsList.length,
      padding: EdgeInsets.symmetric(
        horizontal: config.sw(10), 
        vertical: config.sh(20)
      ),
      separatorBuilder: (c, i) => const YMargin(10),
      itemBuilder: (c, i) {
        return ProductItem(
          image: productsList[i]!.image,
          productName: productsList[i]!.name,
          quantityLeft: productsList[i]!.stockCount,
          sellingPrice: productsList[i]!.sellingPrice,
          onTap: () async {
            final category = await inventoryProvider.getCategoryById(
              categoryId: productsList[i]!.category
            );

            final editRes = await Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditProductView(
                product: productsList[i],
                category: category,
                canEdit: true,
              );
            }));

            if (editRes != null) {
              print("EDIT DONE SUCCESSFULLY");
              bool isEmployee = ref.read(authViewModel).loginResponse?.employee != null;
              var employee = ref.read(authViewModel).loginResponse?.employee;

              final res = await ref.read(inventoryViewModel).getProducts(
                isEmployee: isEmployee,
                branchId: employee?.branch
              );
                  
              setState(() {
                productsList = res!.products!;

              });
            }
          },
        );
      },
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Branch 1", child: Text("Branch 1")),
      const DropdownMenuItem(value: "Branch 2", child: Text("Branch 2")),
      const DropdownMenuItem(value: "Branch 3", child: Text("Branch 3")),
      const DropdownMenuItem(value: "Branch 4", child: Text("Branch 4")),
    ];
    return menuItems;
  }
}