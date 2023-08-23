import 'package:biz_track/features/customer/views/add_customer_view.dart';
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


class SelectCustomerView extends ConsumerStatefulWidget {
  const SelectCustomerView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectCustomerViewState();
}

class _SelectCustomerViewState extends ConsumerState<SelectCustomerView> {

  late final Future myCustomers;

  @override
  void initState() {
    var employee = ref.read(authViewModel).loginResponse?.employee;
    bool isEmployee = ref.read(authViewModel).loginResponse?.employee != null;
    myCustomers = ref.read(customerViewModel).getCustomers(
      isEmployee: isEmployee,
      branchId: employee?.branch
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    var customerProvider = ref.watch(customerViewModel);

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Select customer",
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: config.sw(20), 
              vertical: config.sh(10)
            ),
            color: isDarkMode ? Colors.transparent : Colors.white,
            child: const CustomSearchTextField(
              hint: "Search name or email",
              suffix: Icon(Icons.search),
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
                      style: CustomTextStyle.regular16.copyWith(
                        color: isDarkMode ? Colors.white : ColorPalette.textColor
                      ),
                    ),
                    // subtitle: Text(
                    //   "${customerProvider.customers?[i].email}",
                    //   style: CustomTextStyle.regular14,
                    // ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios, 
                      size: 15
                    ),
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: config.sh(5)),
                    onTap: () {
                      Navigator.pop(context, customerProvider.customers?[i]);
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