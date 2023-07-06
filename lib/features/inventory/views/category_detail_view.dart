import 'package:biz_track/features/inventory/model/categories_response.dart';
import 'package:biz_track/features/inventory/model/products_response.dart';
import 'package:biz_track/features/inventory/views/add_product_view.dart';
import 'package:biz_track/features/inventory/views/edit_product_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
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
                  horizontal: config.sw(22), 
                  vertical: config.sh(20)
                ),
                separatorBuilder: (c, i) => const YMargin(10),
                itemBuilder: (c, i) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(5)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: ListTile(
                      leading: products[i].image!.isEmpty 
                        ? Container(
                            height: config.sh(80),
                            width: config.sw(80),
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent
                            ),
                            child: Image.asset(
                              "empty".png,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Container(
                            height: config.sh(80),
                            width: config.sw(80),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  products[i].image!,
                                ),
                                fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                      title: Text(
                        "${products[i].name}",
                        style: CustomTextStyle.bold16.copyWith(
                          fontSize: config.sp(14)
                        ),
                      ),
                      subtitle: Text(
                        "${products[i].stockCount} Items left",
                        style: CustomTextStyle.regular14,
                      ),
                      trailing: Text(
                        "${currency()} ${parseAmount(products[i].sellingPrice)}",
                        style: CustomTextStyle.regular16,
                      ),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        push(const EditProductView());
                      },
                    ),
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
            onTap: () {
              push(const AddProductView());
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