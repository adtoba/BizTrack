import 'package:biz_track/features/inventory/views/add_product_view.dart';
import 'package:biz_track/features/inventory/views/edit_product_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_search_text_field.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class CategoryDetailView extends ConsumerStatefulWidget {
  const CategoryDetailView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends ConsumerState<CategoryDetailView> {

  String? selectedValue = "Branch 1";

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      backgroundColor: ColorPalette.scaffoldBg,
      appBar: const CustomAppBar(
        title: "Shoes",
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
          Expanded(
            child: ListView.separated(
              itemCount: 4,
              padding: EdgeInsets.symmetric(
                horizontal: config.sw(22), 
                vertical: config.sh(20)
              ),
              separatorBuilder: (c, i) => const YMargin(10),
              itemBuilder: (c, i) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(5)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: ListTile(
                    title: Text(
                      "Wagyu Sate",
                      style: CustomTextStyle.bold16,
                    ),
                    subtitle: Text(
                      "20 Items left",
                      style: CustomTextStyle.regular14,
                    ),
                    trailing: Text(
                      "\$20.99",
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