import 'package:biz_track/features/customer/views/add_customer_view.dart';
import 'package:biz_track/features/customer/views/customer_detail_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_search_text_field.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class CustomerView extends ConsumerStatefulWidget {
  const CustomerView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomerViewState();
}

class _CustomerViewState extends ConsumerState<CustomerView> {

  @override
  void initState() {
    var employee = ref.read(authViewModel).loginResponse?.employee;
    bool isEmployee = ref.read(authViewModel).loginResponse?.employee != null;
    ref.read(customerViewModel).getCustomers(
      isEmployee: isEmployee,
      branchId: employee?.branch
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var customerProvider = ref.watch(customerViewModel);
    var loginProvider = ref.watch(authViewModel);
    var userBranch = loginProvider.userBranch;
    var branch = loginProvider.loginResponse?.employee != null 
      ? "${userBranch?.name}"
      : "all branches";

    return Scaffold(
      backgroundColor: ColorPalette.scaffoldBg,
      appBar: const CustomAppBar(
        title: "Customer",
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
              hint: "Search name or email",
              suffix: Icon(Icons.search),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(10)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Showing results for $branch",
                style: CustomTextStyle.regular14.copyWith(
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
          if(customerProvider.busy)...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(20)),
              child: const CircularProgressIndicator(),
            )
          ] else if(customerProvider.customers!.isEmpty)...[
            const EmptyState(
              text: "You have not created any customer yet",
            )
          ] else ...[
            Expanded(
              child: ListView.separated(
                itemCount: customerProvider.customers!.length,
                padding: EdgeInsets.symmetric(
                  horizontal: config.sw(22), 
                  vertical: config.sh(20)
                ),
                separatorBuilder: (c, i) => const Divider(),
                itemBuilder: (c, i) {
                  return ListTile(
                    title: Text(
                      "${customerProvider.customers?[i].name}",
                      style: CustomTextStyle.regular16,
                    ),
                    // subtitle: Text(
                    //   customerProvider.customers![i].email!.isEmpty 
                    //     ? "No email added"
                    //     : customerProvider.customers![i].email!,
                    //   style: CustomTextStyle.regular14,
                    // ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios, 
                      size: 15
                    ),
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: config.sh(5)),
                    onTap: () {
                      push(CustomerDetailView(
                        customer: customerProvider.customers![i],
                      ));
                    },
                  ); 
                },
              ),
            )
          ],
        ],
      ),
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
          child: CustomAuthButton(
            text: "Add New Customer",
            onTap: () {
              push(const AddCustomerView());
            },
          ),
        )
      ],
    );
  }
}