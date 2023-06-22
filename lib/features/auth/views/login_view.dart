import 'package:biz_track/features/auth/views/login_employee_view.dart';
import 'package:biz_track/features/auth/views/login_owner_view.dart';
import 'package:biz_track/features/auth/views/signup_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Log In",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const YMargin(20),
            Text(
              "Welcome to BizTrack!",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: config.sp(24),
                color: ColorPalette.textColor
              ),
            ),
            const YMargin(10),
            Text(
              "Login as the Business Owner or Business Employee to continue",
              style: CustomTextStyle.regular16,
            ),
            const YMargin(50),
            Center(
              child: SvgPicture.asset(
                "login_in_book".svg,
                alignment: Alignment.center,
              ),
            ),
            const YMargin(20),
            const Spacer(),
            CustomAuthButton(
              icon: const Icon(Icons.person, color: Colors.white),
              text: "Log in as Owner",
              onTap: () {
                push(const LoginOwnerView());
              },
            ),
            const YMargin(20),
            // const YMargin(20),
            // Center(
            //   child: Text("Or", style: CustomTextStyle.regular16,)
            // ),
            // const YMargin(20),
            CustomAuthButton(
              icon: const Icon(Icons.people, color: Colors.white),
              text: "Log in as Employee",
              onTap: () {
                push(const LoginEmployeeView());
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: CustomTextStyle.regular14,
                ),
                TextButton(
                  onPressed: () {
                    push(const SignUpView());
                  }, 
                  child: Text(
                    "Sign Up",
                    style: CustomTextStyle.regular14.copyWith(
                      color: ColorPalette.primary
                    ),
                  )
                )
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}