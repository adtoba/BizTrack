import 'package:biz_track/features/auth/views/login_view.dart';
import 'package:biz_track/features/auth/views/signup_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/buttons/bordered_button.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class WelcomeView extends ConsumerStatefulWidget {
  const WelcomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends ConsumerState<WelcomeView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const YMargin(60),
            Text(
              "BizTrack!",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: config.sp(25),
                color: ColorPalette.primary
              ),
            ),
            const YMargin(20),
            Text(
              "Manage your business the right way",
              textAlign: TextAlign.center,
              style: CustomTextStyle.bold16,
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: Lottie.asset(
                "business_animation".json,
                alignment: Alignment.center,
              ),
            ),            
            const Spacer(),
            CustomAuthButton(
              text: "Create new account",
              onTap: () {
                push(const SignUpView());
              },
            ),
            const YMargin(20),
            CustomBorderedButton(
              text: "Log in",
              onTap: () {
                push(const LoginView());
              },
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}