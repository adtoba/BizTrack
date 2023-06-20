import 'package:biz_track/features/auth/views/login_owner_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
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
      appBar: AppBar(
        title: const Text(
          "Log in"
        ),
        titleTextStyle: TextStyle(
          fontSize: config.sp(20),
          color: ColorPalette.primary,
          fontWeight: FontWeight.w700
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
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
                height: config.sh(250),
                width: config.sw(250),
                alignment: Alignment.center,
              ),
            ),
            const YMargin(20),
            CustomAuthButton(
              icon: const Icon(Icons.person, color: Colors.white),
              text: "Log in as Owner",
              onTap: () {
                push(const LoginOwnerView());
              },
            ),
            const YMargin(10),
            Center(
              child: Text("Or", style: CustomTextStyle.regular16,)
            ),
            const YMargin(10),
            CustomAuthButton(
              icon: const Icon(Icons.people, color: Colors.white),
              text: "Log in as Employee",
              onTap: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: CustomTextStyle.regular16,
                ),
                TextButton(
                  onPressed: () {}, 
                  child: const Text("Sign Up")
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