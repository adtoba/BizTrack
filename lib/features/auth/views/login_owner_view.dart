import 'package:biz_track/features/auth/views/forgot_password_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_text_field.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/utils/validators.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginOwnerView extends ConsumerStatefulWidget {
  const LoginOwnerView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginOwnerViewState();
}

class _LoginOwnerViewState extends ConsumerState<LoginOwnerView> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var loginProvider = ref.watch(authViewModel);

    return LoadingOverlay(
      color: Colors.black,
      isLoading: loginProvider.busy,
      progressIndicator: const CustomLoadingIndicator(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Log in as Owner",
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const YMargin(30),
                  CustomTextField(
                    controller: emailController,
                    label: "Email Address",
                    hint: "Enter your email",
                    validator: Validators.validateEmail,
                  ),
                  const YMargin(20),
                  CustomTextField(
                    controller: passwordController,
                    label: "Password",
                    hint: "At least 8 characters",
                    obscureText: true,
                    validator: Validators.validatePassword,
                  ),
                  const YMargin(30),
                  CustomAuthButton(
                    text: "Login",
                    onTap: () async {
                      if(formKey.currentState!.validate()) {
                        String? email = emailController.text;
                        String? password = passwordController.text;
                        await loginProvider.login(email: email, password: password);
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      push(const ForgotPasswordView());
                    }, 
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: config.sp(14),
                        color: ColorPalette.primary,
                        decoration: TextDecoration.underline
                      ),
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}