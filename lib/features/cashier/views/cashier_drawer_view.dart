import 'package:biz_track/features/account/views/account_view.dart';
import 'package:biz_track/features/history/views/transaction_history_view.dart';
import 'package:biz_track/features/report/views/report_view.dart';
import 'package:biz_track/features/store/views/manage_store_view.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CashierDrawerView extends ConsumerStatefulWidget {
  const CashierDrawerView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CashierDrawerViewState();
}

class _CashierDrawerViewState extends ConsumerState<CashierDrawerView> {

  String selectedValue = "Branch 1";

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const YMargin(60),
          Text(
            "BizTrack!",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: config.sp(20),
              color: ColorPalette.white
            ),
          ),
          const YMargin(16),
          Text(
            "MyNameStore",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontSize: config.sp(22),
              fontWeight: FontWeight.bold
            ),
          ),
          const YMargin(10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(5)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white.withOpacity(.2)
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                items: dropdownItems,
                value: selectedValue,
                style: CustomTextStyle.regular16,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                  });
                }
              ), 
            ),
          ),
          const YMargin(10),
          const Divider(
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: const Icon(Icons.money, color: Colors.white),
            title: Text(
              "Cashier",
              style: CustomTextStyle.regular16.copyWith(
                color: Colors.white
              ),
            ),
          ),
          ListTile(
            onTap: () {
              push(const TransactionHistoryView());
            },
            leading: const Icon(Icons.history, color: Colors.white),
            title: Text(
              "Transaction History",
              style: CustomTextStyle.regular16.copyWith(
                color: Colors.white
              ),
            ),
          ),
          ListTile(
            onTap: () {
              push(const ReportView());
            },
            leading: const Icon(Icons.report, color: Colors.white),
            title: Text(
              "Report",
              style: CustomTextStyle.regular16.copyWith(
                color: Colors.white
              ),
            ),
          ),
          ListTile(
            onTap: () {
              push(const ManageStoreView());
            },
            leading: const Icon(Icons.settings, color: Colors.white),
            title: Text(
              "Manage Store",
              style: CustomTextStyle.regular16.copyWith(
                color: Colors.white
              ),
            ),
          ),
          ListTile(
            onTap: () {
              push(const AccountView());
            },
            leading: const Icon(Icons.account_box, color: Colors.white),
            title: Text(
              "Account",
              style: CustomTextStyle.regular16.copyWith(
                color: Colors.white
              ),
            ),
          ),
          const Spacer(),
          const Divider(
            color: Colors.white,
          ),
          const YMargin(10),
          Row(
            children: [
              SvgPicture.asset(
                "last_login".svg
              ),
              const XMargin(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Last Login:",
                    style: CustomTextStyle.regular16.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  const YMargin(5),
                  Text(
                    "Monday, 01 July 2020\n(12:00 AM)",
                    style: CustomTextStyle.regular14.copyWith(
                      color: Colors.white
                    ),
                  ),
                ],
              )
            ],
          ),
          const YMargin(60)
        ],
      ),
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