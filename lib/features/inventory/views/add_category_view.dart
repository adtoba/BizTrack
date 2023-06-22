import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_text_field.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class AddCategoryView extends ConsumerStatefulWidget {
  const AddCategoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends ConsumerState<AddCategoryView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
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
          child: Column(
            children: const [
              CustomTextField(
                label: "Category Name",
                hint: "John Doe",
              ),
              YMargin(20),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
          child: CustomAuthButton(
            text: "Save",
            onTap: () {},
          ),
        )
      ],
    );
  }
}