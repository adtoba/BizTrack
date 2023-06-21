import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_text_field.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class AddEmployeeView extends ConsumerStatefulWidget {
  const AddEmployeeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddEmployeeViewState();
}

class _AddEmployeeViewState extends ConsumerState<AddEmployeeView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      backgroundColor: ColorPalette.scaffoldBg,
      appBar: const CustomAppBar(
        title: "Add Employee",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: config.sw(22), 
        ),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              YMargin(30),
              CustomTextField(
                label: "Name",
                hint: "John Doe",
              ),
              YMargin(20),
              CustomTextField(
                label: "Phone Number",
                hint: "08112341234",
              ),
              YMargin(20),
              CustomTextField(
                label: "Email",
                hint: "email@email.com",
              ),
              YMargin(20),
              CustomTextField(
                label: "Password",
                hint: "At least 8 characters",
                obscureText: true,
              ),
              YMargin(20),
              CustomTextField(
                label: "Employee Role",
                hint: "Cashier, Manager e.t.c.",
              ),
              YMargin(20),
              CustomTextField(
                label: "Assigned Branch",
                hint: "Branch 1",
              ),
              YMargin(20),
              CustomTextField(
                label: "Address",
                hint: "37 meadow street",
                maxLines: 5,
              ),
              YMargin(20),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
          child: CustomAuthButton(
            text: "Save",
            onTap: () {},
          ),
        )
      ],
    );
  }
}