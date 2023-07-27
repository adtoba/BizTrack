import 'package:biz_track/features/branch/models/get_branch_response.dart';
import 'package:biz_track/features/branch/views/select_branch_view.dart';
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


class AddCategoryView extends ConsumerStatefulWidget {
  const AddCategoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends ConsumerState<AddCategoryView> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final branchController = TextEditingController();

  Branch? selectedBranch;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var inventoryProvider = ref.watch(inventoryViewModel);
    var loginResponse = ref.read(authViewModel).loginResponse;
    var employee = loginResponse?.employee;
    var isEmployee = employee != null;

    return LoadingOverlay(
      isLoading: inventoryProvider.busy,
      progressIndicator: const CustomLoadingIndicator(),
      color: Colors.black,
      child: Scaffold(
        backgroundColor: ColorPalette.scaffoldBg,
        appBar: const CustomAppBar(
          title: "Add Category",
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
                    label: "Category Name",
                    hint: "John Doe",
                    validator: Validators.validateField,
                  ),
                  if(!isEmployee)...[
                    const YMargin(20),
                    InkWell(
                      onTap: () async {
                        Branch? branch = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return const SelectBranchView();
                        }));

                        if(branch != null) {
                          setState(() {
                            branchController.text = branch.name!;
                            selectedBranch = branch;
                          });
                        }
                      },
                      child: CustomTextField(
                        controller: branchController,
                        enabled: false,
                        label: "Branch",
                        hint: "Branch 1",
                        suffix: const Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ],
                  
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
                  await inventoryProvider.createCategory(
                    name: nameController.text,
                    branch: !isEmployee
                      ? selectedBranch?.id
                      : employee.branch
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