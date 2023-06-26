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


class AddBranchView extends ConsumerStatefulWidget {
  const AddBranchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddBranchViewState();
}

class _AddBranchViewState extends ConsumerState<AddBranchView> {

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var branchProvider = ref.watch(branchViewModel);

    return LoadingOverlay(
      isLoading: branchProvider.busy,
      color: Colors.black,
      progressIndicator: const CustomLoadingIndicator(),
      child: Scaffold(
        backgroundColor: ColorPalette.scaffoldBg,
        appBar: const CustomAppBar(
          title: "Add Branch",
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
                    hint: "Branch 1",
                    validator: Validators.validateField,
                  ),
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
                  await branchProvider.createBranch(
                    name: nameController.text
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}