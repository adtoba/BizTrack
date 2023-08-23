import 'package:biz_track/features/inventory/model/categories_response.dart';
import 'package:biz_track/features/inventory/views/add_category_view.dart';
import 'package:biz_track/features/inventory/views/category_detail_view.dart';
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


class ProductCategoryView extends ConsumerStatefulWidget {
  const ProductCategoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductCategoryViewState();
}

class _ProductCategoryViewState extends ConsumerState<ProductCategoryView> {

  ValueNotifier<String?> searchNotifier = ValueNotifier("");

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var employee = ref.read(authViewModel).loginResponse?.employee;
      bool isEmployee = employee != null;

      ref.read(inventoryViewModel).getCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    var inventoryProvider = ref.watch(inventoryViewModel);
    var loginProvider = ref.watch(authViewModel);
    var userBranch = loginProvider.userBranch;
    var branch = loginProvider.loginResponse?.employee != null 
      ? "${userBranch?.name}"
      : "all branches";

    return Scaffold(
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
            color: isDarkMode ? Colors.transparent : Colors.white,
            child: CustomSearchTextField(
              hint: "Search product category",
              prefix: const Icon(Icons.search),
              onChanged: (String? value) {
                searchNotifier.value = value;
              },
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
              child: ValueListenableBuilder<String?>(
                valueListenable: searchNotifier,
                builder: (context, value, _) {
                  if(value == "") {
                    return _buildListView(inventoryProvider.categories);
                  } else {
                    var results = inventoryProvider.categories!.where((element) 
                      => element.name!.toLowerCase().contains(value!.toLowerCase())).toList();
                    return _buildListView(results);
                  }
                },
              ),
            ),
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

  Widget _buildListView(List<Category>? categories) {
    var config = SizeConfig();
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return ListView.separated(
      itemCount: categories!.length,
      padding: EdgeInsets.symmetric(
        horizontal: config.sw(22), 
        vertical: config.sh(20)
      ),
      separatorBuilder: (c, i) => const Divider(
        color: Colors.white30,
      ),
      itemBuilder: (c, i) {
        return ListTile(
          title: Text(
            categories[i].name!,
            style: CustomTextStyle.regular16.copyWith(
              color: isDarkMode ? Colors.white : ColorPalette.textColor
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios, 
            size: 15
          ),
          dense: true,
          contentPadding: EdgeInsets.symmetric(vertical: config.sw(5)),
          onTap: () {
            push(CategoryDetailView(
              category: categories[i],
            ));
          },
        ); 
      },
    );
  }
}