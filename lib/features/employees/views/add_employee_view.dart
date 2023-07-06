import 'package:biz_track/features/branch/models/get_branch_response.dart';
import 'package:biz_track/features/branch/views/select_branch_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_text_field.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/utils/validators.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';


class AddEmployeeView extends ConsumerStatefulWidget {
  const AddEmployeeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddEmployeeViewState();
}

class _AddEmployeeViewState extends ConsumerState<AddEmployeeView> {

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final roleController = TextEditingController();
  final branchController = TextEditingController();
  final addressController = TextEditingController();

  Branch? selectedBranch;

  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var employeeProvider = ref.watch(employeeViewModel);

    return LoadingOverlay(
      isLoading: employeeProvider.busy,
      progressIndicator: const CustomLoadingIndicator(),
      color: Colors.black,
      child: Scaffold(
        backgroundColor: ColorPalette.scaffoldBg,
        appBar: const CustomAppBar(
          title: "Add Employee",
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: config.sw(22), 
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const YMargin(30),
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
                    validator: Validators.validatePhone,
                  ),
                  const YMargin(20),
                  CustomTextField(
                    controller: emailController,
                    label: "Email",
                    hint: "email@email.com",
                    keyboardType: TextInputType.emailAddress,
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
                  const YMargin(20),
                  Text(
                    "Employee Role",
                    style: CustomTextStyle.regular16,
                  ),
                  const YMargin(10),
                  Container(
                    width: double.infinity,
                    height: config.sh(55),
                    padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
                    decoration: BoxDecoration(
                      color:Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        items: const <DropdownMenuItem<String>>[
                          DropdownMenuItem(
                            value: "Cashier",
                            child: Text(
                              "Cashier"
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Manager",
                            child: Text(
                              "Manager"
                            ),
                          )
                        ],
                        value: selectedRole,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: config.sp(16),
                          fontFamily: GoogleFonts.rubik().fontFamily,
                          color: ColorPalette.textColor
                        ),
                        hint: Text(
                          "Select role",
                          style: TextStyle(
                            fontSize: config.sp(13),
                            fontWeight: FontWeight.normal,
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            color: ColorPalette.textColor.withOpacity(.8)
                          )
                        ), 
                        onChanged: ((value) {
                          setState(() {
                            selectedRole = value;
                          });
                        })
                      ),
                    ),
                  ),
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
                      label: "Assigned Branch",
                      hint: "Branch 1",
                      validator: Validators.validateField,
                      suffix: const Icon(Icons.arrow_drop_down),
                      enabled: false,
                    ),
                  ),
                  const YMargin(20),
                  CustomTextField(
                    controller: addressController,
                    label: "Address",
                    hint: "37 meadow street",
                    maxLines: 5,
                    validator: Validators.validateField,
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
                  await employeeProvider.createEmployee(
                    name: nameController.text,
                    password: passwordController.text,
                    address: addressController.text,
                    assignedBranch: selectedBranch?.id,
                    email: emailController.text,
                    employeeRole: selectedRole,
                    phoneNumber: phoneController.text
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