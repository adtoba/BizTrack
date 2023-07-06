import 'package:biz_track/features/employees/views/add_employee_view.dart';
import 'package:biz_track/features/employees/views/employee_detail_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_search_text_field.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/empty_state.dart';
import 'package:biz_track/shared/views/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';


class EmployeesView extends ConsumerStatefulWidget {
  const EmployeesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmployeesViewState();
}

class _EmployeesViewState extends ConsumerState<EmployeesView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(employeeViewModel).fetchEmployees();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var employeeProvider = ref.watch(employeeViewModel);

    return LoadingOverlay(
      isLoading: employeeProvider.getEmployeeBusy,
      color: Colors.black,
      progressIndicator: const CustomLoadingIndicator(),
      child: Scaffold(
        backgroundColor: ColorPalette.scaffoldBg,
        appBar: const CustomAppBar(
          title: "Employees",
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: config.sw(20), 
                vertical: config.sh(10)
              ),
              color: Colors.white,
              child: const CustomSearchTextField(
                hint: "Search for an employee",
                suffix: Icon(Icons.search),
              ),
            ),
            if(employeeProvider.busy)...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(20)),
                child: const CircularProgressIndicator(),
              )
            ] else if(employeeProvider.employees.isEmpty)...[
              const EmptyState(
                text: "You have not created any employees yet",
              )
            ] else ...[
              Expanded(
                child: ListView.separated(
                  itemCount: employeeProvider.employees.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: config.sw(22), 
                    vertical: config.sh(20)
                  ),
                  separatorBuilder: (c, i) => const Divider(),
                  itemBuilder: (c, i) {
                    var employee = employeeProvider.employees[i];

                    return ListTile(
                      title: Text(
                        employee.name!,
                        style: CustomTextStyle.regular16,
                      ),
                      subtitle: Text(
                        employee.role!,
                        style: CustomTextStyle.regular14,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios, 
                        size: 15
                      ),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      onTap: () async {
                        var result = await employeeProvider.fetchEmployeeById(
                          id: employee.id
                        );
                        if(result != null) {
                          push(EmployeeDetailView(
                            employee: result
                          ));
                        }
                      },
                    ); 
                  },
                ),
              )
            ]
          ],
        ),
        persistentFooterButtons: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
            child: CustomAuthButton(
              text: "Create New Employee",
              onTap: () {
                push(const AddEmployeeView());
              },
            ),
          )
        ],
      ),
    );
  }
}