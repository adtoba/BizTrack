import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/buttons/bordered_button.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class EmployeeDetailView extends ConsumerStatefulWidget {
  const EmployeeDetailView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmployeeDetailViewState();
}

class _EmployeeDetailViewState extends ConsumerState<EmployeeDetailView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Employee Detail",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const YMargin(30),
            Row(
              children: const [
                Expanded(
                  child: EmployeeDetailItem(
                    title: "Name",
                    text: "John Doe",
                  ),
                ),
                XMargin(20),
                Expanded(
                  child: EmployeeDetailItem(
                    title: "Email",
                    text: "email@email.com",
                  ),
                ),
              ],
            ),
            const YMargin(30),
            Row(
              children: const [
                Expanded(
                  child: EmployeeDetailItem(
                    title: "Cashier Access Code",
                    text: "ABCD1234#@!",
                  ),
                ),
                XMargin(20),
                Expanded(
                  child: EmployeeDetailItem(
                    title: "Employee Role",
                    text: "Manager",
                  ),
                )
              ],
            ),
            const YMargin(30),
            Row(
              children: const [
                Expanded(
                  child: EmployeeDetailItem(
                    title: "Phone Number",
                    text: "08164818791",
                  ),    
                ),
                XMargin(20),
                Expanded(
                  child: EmployeeDetailItem(
                    title: "Assigned Branch",
                    text: "Branch 1",
                  ),
                )
              ],
            ),
            const YMargin(30),
            const EmployeeDetailItem(
              title: "Address",
              text: "37 meadow street"
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
          child: Column(
            children: [
              CustomAuthButton(
                text: "View Employee Transactions",
                onTap: () {
                  
                },
              ),
              const YMargin(10),
              CustomBorderedButton(
                text: "Edit Detail",
                onTap: () {
                  
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class EmployeeDetailItem extends StatelessWidget {
  const EmployeeDetailItem({super.key, this.title, this.text});

  final String? title;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title!,
          style: CustomTextStyle.regular14,
        ),
        const YMargin(5),
        SelectableText(
          text!,
          style: CustomTextStyle.regular16,
        )
      ],
    );
  }
}