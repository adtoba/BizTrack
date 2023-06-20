import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_text_field.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginOwnerView extends ConsumerStatefulWidget {
  const LoginOwnerView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginOwnerViewState();
}

class _LoginOwnerViewState extends ConsumerState<LoginOwnerView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if(Navigator.canPop(context)) Navigator.pop(context);
          }, 
          icon: SvgPicture.asset(
            "back_button".svg,
            height: config.sh(35),
            width: config.sw(35),
          )
        ),
        title: const Text(
          "Log in as Owner"
        ),
        titleTextStyle: TextStyle(
          fontSize: config.sp(20),
          color: ColorPalette.primary,
          fontWeight: FontWeight.w700
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const YMargin(30),
              const CustomTextField(
                label: "Email or Phone Number",
                hint: "Email or Phone Number",
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
              TextButton(
                onPressed: () {}, 
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: config.sp(12),
                    decoration: TextDecoration.underline
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}