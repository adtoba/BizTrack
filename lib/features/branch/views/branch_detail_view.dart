import 'package:biz_track/features/branch/models/get_branch_response.dart';
import 'package:biz_track/features/employees/views/employee_detail_view.dart';
import 'package:biz_track/features/history/views/all_transactions_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/amount_parser.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class BranchDetailView extends ConsumerStatefulWidget {
  const BranchDetailView({super.key, this.branch});

  final Branch? branch;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BranchDetailViewState();
}

class _BranchDetailViewState extends ConsumerState<BranchDetailView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.branch!.name,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const YMargin(30),
            EmployeeDetailItem(
              title: "Name: ",
              text: widget.branch!.name,
            ),
            const YMargin(20),
            const EmployeeDetailItem(
              title: "No of employees: ",
              text: "10",
            ),
            const YMargin(20),
            EmployeeDetailItem(
              title: "Total Transaction Amount:",
              text: "${currency()} 20,000,00",
            ),
            const YMargin(40),
            CustomAuthButton(
              text: "View Employees",
              onTap: () {

              },
            ),
            const YMargin(10),
            Center(
              child: TextButton(
                onPressed: () {
                  push(AllTransactionsView(
                    branch: widget.branch,
                  ));
                }, 
                child: Text(
                  "View Transactions >>>",
                  style: CustomTextStyle.bold16.copyWith(
                    color: Colors.red
                  ),
                )
              ),
            )   
          ],
        ),
      ),
    );
  }
}