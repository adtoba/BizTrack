import 'package:biz_track/features/branch/views/add_branch_view.dart';
import 'package:biz_track/features/branch/views/branch_detail_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_search_text_field.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class BranchView extends ConsumerStatefulWidget {
  const BranchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BranchViewState();
}

class _BranchViewState extends ConsumerState<BranchView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      backgroundColor: ColorPalette.scaffoldBg,
      appBar: const CustomAppBar(
        title: "Branches",
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
              hint: "Search for a branch",
              suffix: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 4,
              padding: EdgeInsets.symmetric(
                horizontal: config.sw(22), 
                vertical: config.sh(20)
              ),
              separatorBuilder: (c, i) => const Divider(),
              itemBuilder: (c, i) {
                return ListTile(
                  title: Text(
                    "Branch 1",
                    style: CustomTextStyle.regular16,
                  ),
                  subtitle: Text(
                    "5 employees",
                    style: CustomTextStyle.regular14,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios, 
                    size: 15
                  ),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    push(const BranchDetailView());
                  },
                ); 
              },
            ),
          )
        ],
      ),
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
          child: CustomAuthButton(
            text: "Create New Branch",
            onTap: () {
              push(const AddBranchView());
            },
          ),
        )
      ],
    );
  }
}