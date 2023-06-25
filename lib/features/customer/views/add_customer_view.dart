import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_text_field.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/utils/validators.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';


class AddCustomerView extends ConsumerStatefulWidget {
  const AddCustomerView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCustomerViewState();
}

class _AddCustomerViewState extends ConsumerState<AddCustomerView> {

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var customerProvider = ref.watch(customerViewModel);

    return LoadingOverlay(
      isLoading: customerProvider.busy,
      color: Colors.black,
      progressIndicator: const CustomLoadingIndicator(),
      child: Scaffold(
        backgroundColor: ColorPalette.scaffoldBg,
        appBar: const CustomAppBar(
          title: "Add Customer",
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: config.sw(22), 
            vertical: config.sh(20)
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameController,
                    label: "Name",
                    hint: "John Doe",
                    validator: Validators.validateField,
                  ),
                  const YMargin(20),
                  CustomTextField(
                    controller: phoneController,
                    label: "Phone Number",
                    hint: "08112341234",
                    keyboardType: TextInputType.phone,
                  ),
                  const YMargin(20),
                  CustomTextField(
                    controller: emailController,
                    label: "Email",
                    hint: "email@email.com",
                  ),
                  const YMargin(20),
                  CustomTextField(
                    controller: addressController,
                    label: "Address",
                    hint: "37 meadow street",
                    maxLines: 5,
                  ),
                  const YMargin(20),
                ],
              ),
            ),
          ),
        ),
        persistentFooterButtons: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
            child: CustomAuthButton(
              text: "Save",
              onTap: () async {
                if(formKey.currentState!.validate()) {
                  final res = await customerProvider.createCustomer(
                    name: nameController.text,
                    email: emailController.text,
                    address: addressController.text,
                    phone: phoneController.text
                  );

                  if(res != null) {
                    setState(() {
                      nameController.clear();
                      emailController.clear();
                      addressController.clear();
                      phoneController.clear();
                    });
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}