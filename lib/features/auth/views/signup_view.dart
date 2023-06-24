import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_text_field.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Sign Up",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const YMargin(30),
              const CustomTextField(
                label: "Business Name",
                hint: "Enter your business name",
              ),
              const YMargin(20),
              const CustomTextField(
                label: "Email Address",
                hint: "Enter your email address",
              ),
              const YMargin(20),
              const CustomTextField(
                label: "Phone Number",
                hint: "08112341234",
              ),
              const YMargin(20),
              const CustomTextField(
                label: "Password",
                hint: "At least 8 characters",
                obscureText: true,
              ),
              const YMargin(30),
              CustomAuthButton(
                text: "Sign Up",
                onTap: () {},
              ),
              const YMargin(30)
            ],
          ),
        ),
      ),
    );
  }
}