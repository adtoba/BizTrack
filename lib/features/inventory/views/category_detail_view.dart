import 'package:biz_track/features/inventory/model/categories_response.dart';
import 'package:biz_track/features/inventory/model/products_response.dart';
import 'package:biz_track/features/inventory/views/add_product_view.dart';
import 'package:biz_track/features/inventory/views/edit_product_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_search_text_field.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/empty_state.dart';
import 'package:biz_track/shared/views/products_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class CategoryDetailView extends ConsumerStatefulWidget {
  const CategoryDetailView({super.key, this.category});

  final Category? category;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends ConsumerState<CategoryDetailView> {

  String? selectedValue = "Branch 1";

  List<Product> products = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final res = await ref.read(inventoryViewModel).getProductsByCategory(
        categoryId: widget.category!.id
      );

      setState(() {
        products = res!.products!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var inventoryProvider = ref.watch(inventoryViewModel);

    return Scaffold(
      backgroundColor: ColorPalette.scaffoldBg,
      appBar: CustomAppBar(
        title: widget.category!.name,
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
            child: const CustomSearchTextField(
              hint: "Search name of product",
              suffix: Icon(Icons.search),
            ),
          ),
          if(inventoryProvider.getProductsByCategoryBusy)...[
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
              child: ListView.separated(
                itemCount: products.length,
                padding: EdgeInsets.symmetric(
                  horizontal: config.sw(10), 
                  vertical: config.sh(20)
                ),
                separatorBuilder: (c, i) => const YMargin(10),
                itemBuilder: (c, i) {
                  return ProductItem(
                    image: products[i].image,
                    productName: products[i].name,
                    quantityLeft: products[i].stockCount,
                    sellingPrice: products[i].sellingPrice,
                    onTap: () {
                      push(EditProductView(
                        product: products[i],
                        category: widget.category,
                      ));
                    },
                  );
                },
              ),
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
                return AddProductView(
                  category: widget.category
                );
              }));

              if (res != null) {
                final res = await ref.read(inventoryViewModel).getProductsByCategory(
                  categoryId: widget.category!.id
                );

                setState(() {
                  products = res!.products!;
                });
              }
            },
          ),
        )
      ],
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