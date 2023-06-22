import 'package:biz_track/features/inventory/views/add_category_view.dart';
import 'package:biz_track/features/inventory/views/category_detail_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_search_text_field.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class ProductCategoryView extends ConsumerStatefulWidget {
  const ProductCategoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductCategoryViewState();
}

class _ProductCategoryViewState extends ConsumerState<ProductCategoryView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      backgroundColor: ColorPalette.scaffoldBg,
      appBar: const CustomAppBar(
        title: "Product Category",
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
              hint: "Search for a category",
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
              separatorBuilder: (c, i) => const Divider(),
              itemBuilder: (c, i) {
                return ListTile(
                  title: Text(
                    "Shoes",
                    style: CustomTextStyle.regular16,
                  ),
                  subtitle: Text(
                    "5 products",
                    style: CustomTextStyle.regular14,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios, 
                    size: 15
                  ),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    push(const CategoryDetailView());
                  },
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
            text: "Create New Category",
            onTap: () {
              push(const AddCategoryView());
            },
          ),
        )
      ],
    );
  }
}