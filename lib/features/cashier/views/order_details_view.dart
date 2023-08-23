import 'package:biz_track/features/cashier/views/cashier_products_view.dart';
import 'package:biz_track/features/customer/model/create_customer_response.dart';
import 'package:biz_track/features/customer/views/select_customer_view.dart';
import 'package:biz_track/features/order/models/create_order_request.dart';
import 'package:biz_track/shared/buttons/add_button.dart';
import 'package:biz_track/shared/buttons/auth_button.dart';
import 'package:biz_track/shared/buttons/minus_button.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/amount_parser.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:biz_track/shared/views/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';

class OrderDetailsView extends ConsumerStatefulWidget {
  const OrderDetailsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends ConsumerState<OrderDetailsView> {

  Customer? selectedCustomer;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    var cartProvider = ref.watch(cartViewModel);
    var loginProvider = ref.read(authViewModel);
    var orderProvider = ref.watch(orderViewModel);

    return LoadingOverlay(
      color: Colors.black,
      isLoading: orderProvider.busy,
      progressIndicator: const CustomLoadingIndicator(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Order Details",
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () async {
                Customer? customer = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SelectCustomerView();
                }));

                if(customer != null) {
                  setState(() {
                    selectedCustomer = customer;
                  });
                }
              },
              child: Container(
                width: double.infinity,
                color: isDarkMode ? ColorPalette.itemDarkBg : Colors.white,
                padding: EdgeInsets.symmetric(horizontal: config.sw(22), vertical: config.sh(16)),
                child: Row(
                  children: [
                    Text(
                      selectedCustomer == null 
                        ? "Customer"
                        : selectedCustomer!.name!,
                      style: CustomTextStyle.regular16.copyWith(
                        color: isDarkMode ? Colors.white : ColorPalette.textColor
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios, size: 20)
                  ],
                ),
              ),
            ),
            const YMargin(20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (c, i) => Divider(
                        height: config.sh(30),
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
                      itemCount: cartProvider.selectedProducts.values.length,
                      itemBuilder: (c, i) {
                        var product = cartProvider.selectedProducts.values.toList()[i];

                        return Row(
                          children: [
                            MinusButton(
                              onPressed: () {
                                cartProvider.decrementQuantity(product.id!);
                              },
                            ),
                            const XMargin(10),
                            Text(
                              "${product.quantity!}",
                              style: CustomTextStyle.regular16.copyWith(
                                color: isDarkMode ? Colors.white : ColorPalette.textColor
                              ),
                            ),
                            const XMargin(10),
                            AddButton(
                              onPressed: () {
                                cartProvider.incrementQuantity(product.id!);
                              }
                            ),
                            const XMargin(20),
                            Expanded(
                              child: Text(
                                product.name!,
                                style: CustomTextStyle.regular16.copyWith(
                                  color: isDarkMode ? Colors.white : ColorPalette.textColor
                                )
                              ),
                            ),
                            const XMargin(10),
                            Text(
                              "${currency()} ${parseAmount(product.price!.toStringAsFixed(2))}",
                              style: CustomTextStyle.bold16.copyWith(
                                color: isDarkMode ? Colors.white : ColorPalette.textColor
                              )
                            ),
                          ],
                        );
                      },
                    ),
                    Divider(
                      height: config.sh(20),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: config.sw(20)),
                      title: Text(
                        "Discount",
                        style: CustomTextStyle.regular16.copyWith(
                          color: isDarkMode ? Colors.white : ColorPalette.textColor
                        ),
                      ),
                      dense: true,
                      trailing: Icon(Icons.arrow_forward_ios, size: config.sh(20)),
                    ),
                    Divider(
                      height: config.sh(20),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: config.sw(20)),
                      title: Text(
                        "Subtotal",
                        style: CustomTextStyle.bold16.copyWith(
                          color: isDarkMode ? Colors.white : ColorPalette.textColor
                        ),
                      ),
                      trailing: Text(
                        "${currency()} ${parseAmount(cartProvider.subTotal.toStringAsFixed(2))}",
                        style: CustomTextStyle.bold16.copyWith(
                          color: isDarkMode ? Colors.white : ColorPalette.textColor
                        ),
                      ),
                      dense: true,
                    ),
                    Divider(
                      height: config.sh(30),
                    ),
                    const PaymentOptionsWidget(),
                    const YMargin(10),
                  ],
                ),
              ),
            )
          ],
        ),
        persistentFooterButtons: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(10)),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Subtotal",
                      style: CustomTextStyle.bold16.copyWith(
                        color: isDarkMode ? Colors.white : ColorPalette.textColor
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${currency()} ${parseAmount(cartProvider.subTotal.toStringAsFixed(2))}",
                      style: CustomTextStyle.bold16.copyWith(
                        color: isDarkMode ? Colors.white : ColorPalette.textColor
                      ),
                    )
                  ],
                ),
                const YMargin(10),
                CustomAuthButton(
                  text: "Place Order",
                  onTap: () async {
                    List<Orders> orders = [];
                    List<SelectedProduct> products = cartProvider.selectedProducts.values.toList();
                    for(SelectedProduct product in products) {
                      orders.add(
                        Orders(
                          name: product.name,
                          productId: product.id,
                          quantity: product.quantity,
                          total: product.price
                        )
                      );
                    }
                    var req = CreateOrderRequest(
                      orders: orders,
                      branch: loginProvider.loginResponse?.employee != null 
                        ? loginProvider.loginResponse?.employee!.branch
                        : null,
                      customer: selectedCustomer != null 
                        ?  selectedCustomer!.id
                        : null,
                      customerName: selectedCustomer != null
                        ? selectedCustomer!.name
                        : null,
                      cashier: loginProvider.loginResponse?.employee != null 
                        ? loginProvider.loginResponse?.employee?.id
                        : loginProvider.loginResponse?.user?.id,
                      cashierName: loginProvider.loginResponse?.employee != null 
                        ? loginProvider.loginResponse?.employee?.name
                        : "Owner",
                      paymentMethod: cartProvider.selectedPaymentMethod,
                      subtotal: cartProvider.subTotal
                    );

                    await orderProvider.createOrder(req);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PaymentOptionsWidget extends ConsumerStatefulWidget {
  const PaymentOptionsWidget({super.key, this.isSelected});

  final bool? isSelected;

  @override
  ConsumerState<PaymentOptionsWidget> createState() => _PaymentOptionsWidgetState();
}

class _PaymentOptionsWidgetState extends ConsumerState<PaymentOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = ref.watch(cartViewModel);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PaymentOptionItem(
          icon: Icons.money,
          title: "Cash",
          isSelected: cartProvider.selectedPaymentMethod == "cash",
          onTap: () {
            cartProvider.setSelectedPaymentMethod("cash");
          },
        ),
        const XMargin(30),
        PaymentOptionItem(
          icon: Icons.credit_card,
          title: "Credit",
          isSelected: cartProvider.selectedPaymentMethod == "credit",
          onTap: () {
            cartProvider.setSelectedPaymentMethod("credit");
          },
        )
      ],
    );
  }
}

class PaymentOptionItem extends StatelessWidget {
  const PaymentOptionItem({super.key, this.title, this.onTap, this.icon, this.isSelected = false});

  final String? title;
  final IconData? icon;
  final bool? isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(10)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: !isSelected! && isDarkMode
                ? ColorPalette.itemDarkBg
                : !isSelected! && !isDarkMode
                ? ColorPalette.primary.withOpacity(.10)
                : ColorPalette.primary
            ),
            child: Icon(
              icon,
              size: config.sh(30),
              color: !isSelected! && isDarkMode
                ? ColorPalette.primary
                : !isSelected! && !isDarkMode
                ? ColorPalette.primary
                : isSelected! && isDarkMode
                ? Colors.white
                : Colors.white,
            ),
          ),
        ),
        const YMargin(5),
        Text(
          "$title",
          style: CustomTextStyle.regular14.copyWith(
            color: isDarkMode ? Colors.white : ColorPalette.textColor
          ),
        )
      ],
    );
  }
}