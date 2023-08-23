import 'package:biz_track/features/customer/views/customers_view.dart';
import 'package:biz_track/features/inventory/views/product_category_view.dart';
import 'package:biz_track/features/inventory/views/products_view.dart';
import 'package:biz_track/features/printers/views/printer_bluetooth_view.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class ManageStoreView extends ConsumerStatefulWidget {
  const ManageStoreView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ManageStoreViewState();
}

class _ManageStoreViewState extends ConsumerState<ManageStoreView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    var loginProvider = ref.watch(authViewModel);
    var loginResponse = loginProvider.loginResponse;
    var employee = loginProvider.loginResponse?.employee;
    var canManageBusiness = employee != null 
      && employee.role?.toLowerCase() == "manager"
    || employee == null && loginProvider.loginResponse?.user != null;

    var isOwner = employee == null && loginProvider.loginResponse?.user != null;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Manage Store",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YMargin(30),
              Text(
                "Manage Business",
                style: CustomTextStyle.bold16.copyWith(
                  fontSize: config.sp(18),
                  color: isDarkMode ? ColorPalette.white : ColorPalette.textColor
                ),
              ),

              const YMargin(10),
              ManageStoreItem(
                icon: "product",
                title: "Products",
                subtitle: "Manage your products",
                onTap: () {
                  push(const ProductsView());
                },
              ),
              const Divider(
                color: Colors.white30,
              ),
              ManageStoreItem(
                icon: "category",
                title: "Category",
                subtitle: "See and manage all your products categories",
                onTap: () {
                  push(const ProductCategoryView());
                },
              ),
              const Divider(
                color: Colors.white30,
              ),
              ManageStoreItem(
                icon: "customer",
                title: "Customers",
                subtitle: "Manage all your saved customers",
                onTap: () {
                  push(const CustomerView());
                },
              ),
              const Divider(
                color: Colors.white30,
              ),

              if(canManageBusiness)...[
                const YMargin(20),
                Text(
                  "Payment",
                  style: CustomTextStyle.bold16.copyWith(
                    fontSize: config.sp(18),
                    color: isDarkMode ? ColorPalette.white : ColorPalette.textColor
                  ),
                ),
                const YMargin(10),
                ManageStoreItem(
                  icon: "payment_method",
                  title: "Payment Method",
                  subtitle: "Create and edit your payment methods",
                  onTap: () {},
                ),
                const Divider(color: Colors.white30,),
                ManageStoreItem(
                  icon: "discount",
                  title: "Discounts",
                  subtitle: "Create and manage all your discounts",
                  onTap: () {},
                ),
                const Divider(color: Colors.white30,),
              ],
              

              const YMargin(20),
              Text(
                "Printer & Receipt",
                style: CustomTextStyle.bold16.copyWith(
                  fontSize: config.sp(18),
                  color: isDarkMode ? ColorPalette.white : ColorPalette.textColor
                ),
              ),
              const YMargin(10),
              ManageStoreItem(
                icon: "printer",
                title: "Printers",
                subtitle: "Find & connect your printer",
                onTap: () {
                  push(const PrinterBluetoothView());
                },
              ),
              const Divider(color: Colors.white30,),
              ManageStoreItem(
                icon: "receipt",
                title: "Customize Receipt",
                subtitle: "Customize your receipt to your taste",
                onTap: () {},
              ),
              const Divider(color: Colors.white30,),

              
              const YMargin(30)
            ],
          ),
        ),
      ),
    );
  }
}

class ManageStoreItem extends StatelessWidget {
  const ManageStoreItem({super.key, this.title, this.subtitle, this.onTap, this.icon});

  final String? title;
  final String? subtitle;
  final String? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: config.sh(8), horizontal: config.sw(5)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: config.sw(8), vertical: config.sh(8)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorPalette.primary.withOpacity(.10)
              ),
              child: Image.asset(
                icon!.png,
                height: config.sh(20),
                width: config.sw(20),
                color: ColorPalette.primary,
              ),
            ),
            const XMargin(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: CustomTextStyle.regular16.copyWith(
                    color: isDarkMode ? ColorPalette.white : ColorPalette.textColor
                  ),
                ),
                const YMargin(5),
                Text(
                  "$subtitle",
                  style: CustomTextStyle.regular14.copyWith(
                    color: Colors.grey
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios, 
              size: config.sh(15)
            )
          ],
        ),
      ),
    );
  }
}