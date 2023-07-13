import 'package:biz_track/features/cashier/views/cashier_products_view.dart';
import 'package:biz_track/features/inventory/model/categories_response.dart';
import 'package:biz_track/features/inventory/model/products_response.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CartVm extends ChangeNotifier {
  late ChangeNotifierProviderRef ref;

  CartVm(ChangeNotifierProviderRef providerRef) {
    ref = providerRef;
  }

  List<Product>? allProducts = [];
  List<Product>? products = [];

  void setProducts(List<Product>? value) async {
    products = value;
    notifyListeners();
  }

  void setAllProducts(List<Product>? value) async {
    allProducts = value;
    notifyListeners();
  }

  Category? selectedCategory;

  void loadProducts() async {
    final res = await ref.read(inventoryViewModel).getProducts();
    products = res?.products ?? [];
    notifyListeners();
  }

  void onDropDownChange(Category? value) async {
    if(value?.name == "All Products") {
      final res = await ref.read(inventoryViewModel).getProducts();
      products = res?.products ?? [];
      notifyListeners();

    } else {
      final res = await ref.read(inventoryViewModel).getProductsByCategory(
        categoryId: value?.id
      );
      products = res?.products ?? [];
      notifyListeners();

    }

    selectedCategory = value;
    notifyListeners();
  }

  List<DropdownMenuItem<Category>> get dropdownItems{
    List<DropdownMenuItem<Category>> menuItems =  ref.watch(inventoryViewModel).cashierCategories!.map((e) {
      return DropdownMenuItem<Category>(
        value: e, 
        child: Text(e.name!),
      );
    }).toList();
    return menuItems;
  }

  Map<String, SelectedProduct> selectedProducts = {};
  double subTotal = 0;
  String? selectedPaymentMethod = "";
  


  void setSelectedPaymentMethod(String value) {
    selectedPaymentMethod = value;
    notifyListeners();
  }

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
    if(product!.availableQuantity! - 1 >= product.quantity!) {
      if(selectedProducts.containsKey(product.id)) {
        selectedProducts.addAll({
          productId: SelectedProduct(
            id: product.id,
            name: product.name,
            price: product.price! + product.sellingPrice!,
            quantity: product.quantity! + 1,
            availableQuantity: product.availableQuantity,
            sellingPrice: product.sellingPrice
          )
        });
      } else {
          addAllProducts({
            product.id! : SelectedProduct(
              name: product.name,
              id: product.id,
              price: double.parse(product.sellingPrice!.toStringAsFixed(2)),
              quantity: 1,
              availableQuantity: product.availableQuantity,
              sellingPrice: double.parse(product.sellingPrice!.toStringAsFixed(2))
            )
          });
      }

      calculateSubTotal();
      notifyListeners();
    }
    
    
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
          availableQuantity: product.availableQuantity,
          sellingPrice: product.sellingPrice
        )
      });
    }
    calculateSubTotal();
    notifyListeners();
  }


  void clear() {
    subTotal = 0;
    selectedProducts.clear();
    selectedPaymentMethod = null;
    notifyListeners();
  }

}