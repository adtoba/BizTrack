import 'package:biz_track/features/customer/views/customers_view.dart';
import 'package:biz_track/features/employees/views/employees_view.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
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
                "Products",
                style: CustomTextStyle.bold16.copyWith(
                  fontSize: config.sp(18)
                ),
              ),
              const YMargin(10),
              ManageStoreItem(
                title: "Products",
                onTap: () {},
              ),
              const Divider(),
              ManageStoreItem(
                title: "Product Category",
                onTap: () {},
              ),
              const Divider(),
              ManageStoreItem(
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
                title: "Payment Method",
                onTap: () {},
              ),
              const Divider(),
              ManageStoreItem(
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
                title: "Printer",
                onTap: () {},
              ),
              const Divider(),
              ManageStoreItem(
                title: "Receipt",
                onTap: () {},
              ),
              const Divider(),

              const YMargin(20),
              Text(
                "Branch & Employee",
                style: CustomTextStyle.bold16.copyWith(
                  fontSize: config.sp(18)
                ),
              ),
              const YMargin(10),
              ManageStoreItem(
                title: "Branch List",
                onTap: () {},
              ),
              const Divider(),
              ManageStoreItem(
                title: "Employee List",
                onTap: () {
                  push(const EmployeesView());
                },
              ),
              const Divider(),
              ManageStoreItem(
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
  const ManageStoreItem({super.key, this.title, this.onTap});

  final String? title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: config.sh(8)),
        child: Row(
          children: [
            Text(
              "$title",
              style: CustomTextStyle.regular16,
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 20,)
          ],
        ),
      ),
    );
  }
}