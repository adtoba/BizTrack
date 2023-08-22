import 'package:biz_track/features/branch/models/get_branch_response.dart';
import 'package:biz_track/features/inventory/model/categories_response.dart';
import 'package:biz_track/features/inventory/model/products_response.dart';
import 'package:biz_track/features/inventory/views/select_category_view.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/input/custom_text_field.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/utils/validators.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';


class EditProductView extends ConsumerStatefulWidget {
  const EditProductView({super.key, this.product, this.category, this.canEdit = false});
  
  final Product? product;
  final Category? category;
  final bool? canEdit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProductViewState();
}

class _EditProductViewState extends ConsumerState<EditProductView> {

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final sellingPriceController = TextEditingController();
  final categoryController = TextEditingController();
  final branchController = TextEditingController();
  final purchasePriceController = TextEditingController();
  final barcodeController = TextEditingController();
  final stockCountController = TextEditingController();

  Branch? selectedBranch;
  Category? selectedCategory;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.category != null) {
        setState(() {
          selectedCategory = widget.category;
          categoryController.text = selectedCategory!.name!;
        });
      }

      if(widget.product != null) {
        setState(() {
          nameController.text = widget.product!.name!;
          sellingPriceController.text = widget.product!.sellingPrice!;
          categoryController.text = widget.category!.name!;
          purchasePriceController.text = widget.product!.purchasePrice!;
          barcodeController.text = widget.product!.barCode!;
          stockCountController.text = widget.product!.stockCount!.toString();
        });
      }
    });
    super.initState();
  }

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
          title: "Edit Product",
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
                    label: "Name of product",
                    hint: "John Doe",
                    validator: Validators.validateField,
                  ),
                  const YMargin(20),
                  CustomTextField(
                    controller: sellingPriceController,
                    label: "Selling Price",
                    hint: "\$100",
                    keyboardType: TextInputType.number,
                    validator: Validators.validateField,
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
                  InkWell(
                    onTap: () async {
                      if(widget.category == null && widget.canEdit == true) {
                        Category? category = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const SelectCategoryView();
                        }));

                        if(category != null) {
                          setState(() {
                            categoryController.text = category.name!;
                            selectedCategory = category;
                          });
                        }
                      }
                    },
                    child: CustomTextField(
                      controller: categoryController,
                      label: "Category",
                      hint: "Choose category",
                      enabled: false,
                      suffix: const Icon(Icons.arrow_drop_down),
                    ),
                  ),
                  const YMargin(20),
                  CustomTextField(
                    controller: purchasePriceController,
                    label: "Purchase Price",
                    keyboardType: TextInputType.number,
                    hint: "\$80",
                  ),
                  const YMargin(20),
                  CustomTextField(
                    controller: barcodeController,
                    label: "Barcode",
                    hint: "10",
                    suffix: const Icon(Icons.qr_code_scanner),
                  ),
                  const YMargin(20),
                  CustomTextField(
                    controller: stockCountController,
                    label: "Stock count",
                    hint: "Enter no of items available",
                    keyboardType: TextInputType.number,
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
              text: "Update Product",
              onTap: () async {
                if(formKey.currentState!.validate()) {
                  await inventoryProvider.createProduct(
                    productName: nameController.text,
                    category: selectedCategory!.id,
                    branch: !isEmployee
                      ? selectedBranch?.id
                      : employee.branch,
                    image: "",
                    purchasePrice: purchasePriceController.text,
                    sellingPrice: sellingPriceController.text,
                    stockCount: int.parse(stockCountController.text),
                    barcode: barcodeController.text
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