import 'package:biz_track/features/auth/views/login_view.dart';
import 'package:biz_track/shared/buttons/bordered_button.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/constants.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/utils/storage.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class AccountView extends ConsumerStatefulWidget {
  const AccountView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountViewState();
}

class _AccountViewState extends ConsumerState<AccountView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var authProvider = ref.watch(authViewModel);
    var loginResponse = authProvider.loginResponse;
    var user = loginResponse!.user;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Account",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YMargin(30),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 45,
                  ),
                  const XMargin(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user?.businessName}",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: ColorPalette.textColor,
                          fontSize: config.sp(22),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const YMargin(5),
                      Text(
                        "${user?.phoneNumber}",
                        style: CustomTextStyle.regular14,
                      ),
                      const YMargin(5),
                      Text(
                        "${user?.email}",
                        style: CustomTextStyle.regular14,
                      )
                    ],
                  )
                ],
              ),
              const YMargin(30),
              ManageStoreItem(
                title: "Account Settings",
                onTap: () {},
              ),
              const Divider(),
              ManageStoreItem(
                title: "Business Information",
                onTap: () {},
              ),
              // const Divider(),
              // ManageStoreItem(
              //   title: "Dashboard",
              //   onTap: () {},
              // ),
             
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
          child: CustomBorderedButton(
            color: Colors.red,
            text: "Log Out",
            onTap: () async {
              await LocalStorage.removeItem(AppConstants.token);
              pushAndRemoveUntil(const LoginView());
            },
          ),
        )
      ],
    );
  }
}

class ManageStoreItem extends StatelessWidget {
  const ManageStoreItem({super.key, this.title, this.onTap});

  final String? title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: config.sh(8)),
        child: Row(
          children: [
            Text(
              "$title",
              style: CustomTextStyle.regular16,
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 20,)
          ],
        ),
      ),
    );
  }
}