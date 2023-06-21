import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/buttons/bordered_button.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class CustomerDetailView extends ConsumerStatefulWidget {
  const CustomerDetailView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomerDetailViewState();
}

class _CustomerDetailViewState extends ConsumerState<CustomerDetailView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Customer Detail",
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
                    title: "Phone Number",
                    text: "08164818791",
                  ),    
                ),
                XMargin(20),
                Expanded(
                  child: EmployeeDetailItem(
                    title: "Address",
                    text: "30 abiola adeyemi street",
                  ),
                )
              ],
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
                text: "View Customer Transactions",
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