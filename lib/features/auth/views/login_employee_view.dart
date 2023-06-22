import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_text_field.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginEmployeeView extends ConsumerStatefulWidget {
  const LoginEmployeeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __LoginEmployeeViewState();
}

class __LoginEmployeeViewState extends ConsumerState<LoginEmployeeView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Log in as Employee",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const YMargin(30),
              const CustomTextField(
                label: "Cashier code",
                hint: "ABC23654",
              ),
              const YMargin(20),
              const CustomTextField(
                label: "Password",
                hint: "At least 8 characters",
                obscureText: true,
              ),
              const YMargin(30),
              CustomAuthButton(
                text: "Login",
                onTap: () {},
              ),
              const YMargin(40),
              const InfoWidget(
                info: "Use the cashier code that can be created by the Owner in"
                " Manage Store -> Cashier Code",
              )
            ],
          ),
        ),
      ),
    );
  }
}