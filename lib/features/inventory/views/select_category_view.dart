import 'package:biz_track/features/inventory/views/add_category_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_search_text_field.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class SelectCategoryView extends ConsumerStatefulWidget {
  const SelectCategoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectCategoryViewState();
}

class _SelectCategoryViewState extends ConsumerState<SelectCategoryView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(inventoryViewModel).getCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var inventoryProvider = ref.watch(inventoryViewModel);

    return Scaffold(
      backgroundColor: ColorPalette.scaffoldBg,
      appBar: const CustomAppBar(
        title: "Select Category",
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
          if(inventoryProvider.busy)...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(20)),
              child: const CircularProgressIndicator(),
            )
          ] else if(inventoryProvider.categories!.isEmpty)...[
            const EmptyState(
              text: "You have not created any category yet",
            )
          ] else ...[
            Expanded(
              child:  ListView.separated(
                itemCount: inventoryProvider.categories!.length,
                padding: EdgeInsets.symmetric(
                  horizontal: config.sw(22), 
                  vertical: config.sh(20)
                ),
                separatorBuilder: (c, i) => const Divider(),
                itemBuilder: (c, i) {
                  return ListTile(
                    title: Text(
                      inventoryProvider.categories![i].name!,
                      style: CustomTextStyle.regular16,
                    ),
                    // subtitle: Text(
                    //   "5 employees",
                    //   style: CustomTextStyle.regular14,
                    // ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios, 
                      size: 15
                    ),
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: config.sw(5)),
                    onTap: () {
                      Navigator.pop(context, inventoryProvider.categories![i]);
                    },
                  ); 
                },
              ),
            )
          ],
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