import 'package:biz_track/features/customer/views/customer_detail_view.dart';
import 'package:biz_track/features/inventory/views/add_product_view.dart';
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


class ProductsView extends ConsumerStatefulWidget {
  const ProductsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState<ProductsView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
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
                  padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(10)),
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
                      "All Branch",
                      style: CustomTextStyle.regular14,
                    ),
                    trailing: Text(
                      "\$20.99",
                      style: CustomTextStyle.regular16,
                    ),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      push(const CustomerDetailView());
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
}