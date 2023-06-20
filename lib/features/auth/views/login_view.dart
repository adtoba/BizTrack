import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/buttons/bordered_button.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/info_widget.dart';
import 'package:flutter/material.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAuthButton(
              text: "Create new account",
              onTap: () {},
            ),
            const YMargin(20),
            CustomBorderedButton(
              text: "Login",
              onTap: () {},
            ),
            const YMargin(20),
            CustomAuthButton(
              text: "Log in as Owner",
              icon: const Icon(Icons.person, color: Colors.white),
              onTap: () {},
            ),
            const YMargin(20),
            const InfoWidget(
              info: "Use the cashier code that can be created by the Owner in "
              "Manage Store -> Cashier Code",
            )
          ],
        ),
      ),
    );
  }
}