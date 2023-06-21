import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_text_field.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class AddProductView extends ConsumerStatefulWidget {
  const AddProductView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductViewState();
}

class _AddProductViewState extends ConsumerState<AddProductView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      backgroundColor: ColorPalette.scaffoldBg,
      appBar: const CustomAppBar(
        title: "Add Product",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: config.sw(22), 
          vertical: config.sh(20)
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomTextField(
                label: "Name of product",
                hint: "John Doe",
              ),
              const YMargin(20),
              const CustomTextField(
                label: "Selling Price",
                hint: "\$100",
              ),
              const YMargin(20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(5)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: ColorPalette.textColor
                  )
                ),
                child: Row(
                  children: [
                    Container(
                      height: config.sw(80),
                      width: config.sw(80),
                      padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(10)),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: SvgPicture.asset(
                        "no_image".svg
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          ColorPalette.textColor
                        )
                      ),
                      child: Text(
                        "Choose Photo",
                        style: CustomTextStyle.regular14.copyWith(
                          color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const YMargin(20),
              const CustomTextField(
                label: "Category",
                hint: "Choose category",
              ),
              const YMargin(20),
              const CustomTextField(
                label: "Purchase Price",
                hint: "\$80",
              ),
              const YMargin(20),
              const CustomTextField(
                label: "Barcode",
                hint: "10",
                suffix: Icon(Icons.qr_code_scanner),
              ),
              const YMargin(20),
              const CustomTextField(
                label: "Branch",
                hint: "Branch 1",
              ),
              const YMargin(20),
              const CustomTextField(
                label: "Stock count",
                hint: "10",
              ),
              const YMargin(20),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
          child: CustomAuthButton(
            text: "Add New Product",
            onTap: () {},
          ),
        )
      ],
    );
  }
}