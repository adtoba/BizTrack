import 'package:biz_track/features/cashier/views/cashier_products_view.dart';
import 'package:flutter/material.dart';


class CartVm extends ChangeNotifier {

  Map<String, SelectedProduct> selectedProducts = {};
  double subTotal = 0;

  void addAllProducts(Map<String, SelectedProduct> products) {
    selectedProducts.addAll(products);
    calculateSubTotal();
    notifyListeners();
  }

  void clearCart() {
    selectedProducts.clear();
    calculateSubTotal();
    notifyListeners();
  }

  void calculateSubTotal() {
    double total = 0;

    List<SelectedProduct> products = selectedProducts.values.toList();
    for(SelectedProduct product in products) {
      total = total + product.price!;
    }

    subTotal = total;
    notifyListeners();
  }

  void removeFromCart(String productId) {
    selectedProducts.remove(productId);
    notifyListeners();
  } 

  void incrementQuantity(String productId) {
    SelectedProduct? product = selectedProducts[productId];
    selectedProducts.addAll({
      productId: SelectedProduct(
        id: product!.id,
        name: product.name,
        price: product.price! + product.sellingPrice!,
        quantity: product.quantity! + 1,
        sellingPrice: product.sellingPrice
      )
    });
    calculateSubTotal();
    notifyListeners();
  }

  void decrementQuantity(String productId) {
    SelectedProduct? product = selectedProducts[productId];

    if(product!.quantity! > 1) {
      selectedProducts.addAll({
        productId: SelectedProduct(
          id: product.id,
          name: product.name,
          price: product.price! - product.sellingPrice!,
          quantity: product.quantity! - 1,
          sellingPrice: product.sellingPrice
        )
      });
    }
    calculateSubTotal();
    notifyListeners();
  }


}