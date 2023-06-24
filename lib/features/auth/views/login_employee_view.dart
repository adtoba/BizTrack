import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_text_field.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/utils/validators.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/info_widget.dart';
import 'package:biz_track/shared/views/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginEmployeeView extends ConsumerStatefulWidget {
  const LoginEmployeeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __LoginEmployeeViewState();
}

class __LoginEmployeeViewState extends ConsumerState<LoginEmployeeView> {

  final formKey = GlobalKey<FormState>();
  final accessCodeController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var authProvider = ref.watch(authViewModel);

    return LoadingOverlay(
      color: Colors.black,
      isLoading: authProvider.busy,
      progressIndicator: const CustomLoadingIndicator(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Log in as Employee",
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
                    controller: accessCodeController,
                    label: "Cashier code",
                    hint: "ABC23654",
                    validator: Validators.validateField,
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
                        String? accessCode = accessCodeController.text;
                        String? password = passwordController.text;

                        await authProvider.employeeLogin(
                          accessCode: accessCode,
                          password: password
                        );
                      }
                    },
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
        ),
      ),
    );
  }
}