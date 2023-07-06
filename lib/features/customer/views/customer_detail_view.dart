import 'package:biz_track/features/customer/model/create_customer_response.dart';
import 'package:biz_track/features/history/views/all_transactions_view.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class CustomerDetailView extends ConsumerStatefulWidget {
  const CustomerDetailView({super.key, required this.customer});

  final Customer customer;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomerDetailViewState();
}

class _CustomerDetailViewState extends ConsumerState<CustomerDetailView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var orderProvider = ref.watch(orderViewModel);

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      appBar: CustomAppBar(
        title: widget.customer.name,
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
              text: "${widget.customer.name}",
            ),
            const YMargin(20),
            EmployeeDetailItem(
              title: "Email: ",
              text: widget.customer.email!.isNotEmpty 
                ? widget.customer.email
                : "None",
            ),
            const YMargin(20),
            EmployeeDetailItem(
              title: "Phone Number:",
              text: widget.customer.phoneNumber!.isNotEmpty 
                ? widget.customer.phoneNumber
                : "None",
            ),
            const YMargin(20),
            EmployeeDetailItem(
              title: "Address:",
              text: widget.customer.address!.isNotEmpty
                ? widget.customer.address
                : "None",
            ),
            Divider(
              height: config.sh(30),
            ),
            const YMargin(10),
            Center(
              child: TextButton(
                onPressed: () {
                  push(AllTransactionsView(
                    customer: widget.customer
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