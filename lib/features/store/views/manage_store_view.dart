import 'package:biz_track/features/branch/views/branches_view.dart';
import 'package:biz_track/features/customer/views/customers_view.dart';
import 'package:biz_track/features/employees/views/employees_view.dart';
import 'package:biz_track/features/inventory/views/product_category_view.dart';
import 'package:biz_track/features/inventory/views/products_view.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/error_util.dart';
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
    var loginProvider = ref.watch(authViewModel);
    var loginResponse = loginProvider.loginResponse;

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
                "Inventory",
                style: CustomTextStyle.bold16.copyWith(
                  fontSize: config.sp(18)
                ),
              ),
              const YMargin(10),
              ManageStoreItem(
                icon: "product",
                title: "Products",
                onTap: () {
                  push(const ProductsView());
                },
              ),
              const Divider(),
              ManageStoreItem(
                icon: "category",
                title: "Product Category",
                onTap: () {
                  push(const ProductCategoryView());
                },
              ),
              const Divider(),
              ManageStoreItem(
                icon: "discount",
                title: "Discount",
                onTap: () {},
              ),
              const Divider(),

              const YMargin(20),
              Text(
                "Cashier & Payment",
                style: CustomTextStyle.bold16.copyWith(
                  fontSize: config.sp(18)
                ),
              ),
              const YMargin(10),
              ManageStoreItem(
                icon: "payment_method",
                title: "Payment Method",
                onTap: () {},
              ),
              const Divider(),
              ManageStoreItem(
                icon: "discount",
                title: "Tax & Service Charge",
                onTap: () {},
              ),
              const Divider(),

              const YMargin(20),
              Text(
                "Printer & Receipt",
                style: CustomTextStyle.bold16.copyWith(
                  fontSize: config.sp(18)
                ),
              ),
              const YMargin(10),
              ManageStoreItem(
                icon: "printer",
                title: "Printer",
                onTap: () {},
              ),
              const Divider(),
              ManageStoreItem(
                icon: "receipt",
                title: "Receipt",
                onTap: () {},
              ),
              const Divider(),

              const YMargin(20),
              Text(
                "Manage Business",
                style: CustomTextStyle.bold16.copyWith(
                  fontSize: config.sp(18)
                ),
              ),
              const YMargin(10),
              ManageStoreItem(
                icon: "branch",
                title: "Branches",
                onTap: () {
                  if(loginResponse?.employee == null) {
                    push(const BranchView());
                  } else {
                    ErrorUtil.showErrorSnackbar("Only owners can perform this action");
                  }
                },
              ),
              const Divider(),
              ManageStoreItem(
                icon: "employee",
                title: "Employees",
                onTap: () {
                  if(loginResponse?.employee == null) {
                    push(const EmployeesView());
                  } else {
                    ErrorUtil.showErrorSnackbar("Only owners can perform this action");
                  }
                },
              ),
              const Divider(),
              ManageStoreItem(
                icon: "customer",
                title: "Customer",
                onTap: () {
                  push(const CustomerView());
                },
              ),
              const Divider(),
              const YMargin(30)
            ],
          ),
        ),
      ),
    );
  }
}

class ManageStoreItem extends StatelessWidget {
  const ManageStoreItem({super.key, this.title, this.onTap, this.icon});

  final String? title;
  final String? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

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
            Text(
              "$title",
              style: CustomTextStyle.regular16,
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