import 'package:biz_track/features/employees/model/create_employee_response.dart';
import 'package:biz_track/features/history/views/all_transactions_view.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class EmployeeDetailView extends ConsumerStatefulWidget {
  const EmployeeDetailView({super.key, required this.employee});

  final Employee employee;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmployeeDetailViewState();
}

class _EmployeeDetailViewState extends ConsumerState<EmployeeDetailView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var orderProvider = ref.watch(orderViewModel);

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      appBar: CustomAppBar(
        title: widget.employee.name,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const YMargin(20),
            // Text(
            //   "Employee Information",
            //   style: CustomTextStyle.bold16.copyWith(
            //     fontSize: config.sp(18)
            //   ),
            // ),
            // const YMargin(20),
            EmployeeDetailItem(
              title: "Name: ",
              text: "${widget.employee.name}",
            ),
            const YMargin(20),
            EmployeeDetailItem(
              title: "Email: ",
              text: widget.employee.email,
            ),
            const YMargin(20),
            EmployeeDetailItem(
              title: "Phone Number:",
              text: widget.employee.phoneNumber,
            ),
            const YMargin(20),
            EmployeeDetailItem(
              title: "Cashier Access Code: ",
              text: widget.employee.accessCode,
            ),
            const YMargin(20),
            EmployeeDetailItem(
              title: "Role: ",
              text: widget.employee.role,
            ),
            const YMargin(20),
            EmployeeDetailItem(
              title: "Assigned Branch: ",
              text: widget.employee.branch!.name!.isNotEmpty
                ? widget.employee.branch!.name
                : "None",
            ),
            const YMargin(20),
            EmployeeDetailItem(
              title: "Address:",
              text: widget.employee.address,
            ),
            Divider(
              height: config.sh(30),
            ),
            const YMargin(10),
            Center(
              child: TextButton(
                onPressed: () {
                  push(AllTransactionsView(employee: widget.employee));
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
      // persistentFooterButtons: [
      //   Padding(
      //     padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
      //     child: Column(
      //       children: [
      //         CustomAuthButton(
      //           text: "All Transactions",
      //           onTap: () {
                  
      //           },
      //         ),
      //         const YMargin(10),
      //         CustomBorderedButton(
      //           text: "Delete Employee",
      //           color: Colors.red,
      //           onTap: () {
                  
      //           },
      //         ),
      //       ],
      //     ),
      //   )
      // ],
    );
  }
}

class EmployeeDetailItem extends StatelessWidget {
  const EmployeeDetailItem({super.key, this.title, this.text});

  final String? title;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title!,
          style: CustomTextStyle.regular16,
        ),
        const YMargin(10),
        Expanded(
          child: SelectableText(
            text!,
            textAlign: TextAlign.end,
            style: CustomTextStyle.bold16,
          ),
        )
      ],
    );
  }
}