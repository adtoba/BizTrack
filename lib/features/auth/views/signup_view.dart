import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_text_field.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/utils/validators.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final businessNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var authProvider = ref.watch(authViewModel);

    return LoadingOverlay(
      isLoading: authProvider.busy,
      color: Colors.black,
      progressIndicator: const CustomLoadingIndicator(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Sign Up",
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
                    controller: businessNameController,
                    label: "Business Name",
                    hint: "Enter your business name",
                    validator: Validators.validateField,
                  ),
                  const YMargin(20),
                  CustomTextField(
                    controller: emailController,
                    label: "Email Address",
                    hint: "Enter your email address",
                    validator: Validators.validateEmail,
                  ),
                  const YMargin(20),
                  CustomTextField(
                    controller: phoneController,
                    label: "Phone Number",
                    hint: "08112341234",
                    keyboardType: TextInputType.phone,
                    validator: Validators.validatePhone,
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
                    text: "Sign Up",
                    onTap: () async {
                      if(formKey.currentState!.validate()) {
                        String? businessName = businessNameController.text;
                        String? email = emailController.text;
                        String? phone = phoneController.text;
                        String? password = passwordController.text;

                        await authProvider.register(
                          businessName: businessName,
                          email: email,
                          password: password,
                          phone: phone
                        );
                      }
                    },
                  ),
                  const YMargin(30)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}