
import 'package:biz_track/features/inventory/model/categories_response.dart';
import 'package:biz_track/features/inventory/model/products_response.dart';
import 'package:biz_track/main.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashierDashboardVm extends ChangeNotifier {
  late ChangeNotifierProviderRef ref;
  
  CashierDashboardVm(ChangeNotifierProviderRef providerRef) {
    ref = providerRef;
  }

  List<Category> _categories = [
    Category(
      name: "All Products",
      id: ""
    )
  ];
  List<Category>? get categories => _categories;

  List<Product>? _products = [];
  List<Product>? get products => _products;

  Category? _selectedCategory;
  Category? get selectedCategory => _selectedCategory;

  void resetCategory() {
    _selectedCategory = null;
    notifyListeners();
  }

  List<DropdownMenuItem<Category>> _categoryItems = [];
  List<DropdownMenuItem<Category>> get categoryItems => _categoryItems;

  void addProductsToCategory(List<Category>? values) {
    if(values != null) _categories.addAll(values);
    notifyListeners();
  }

  Future<void> getProducts() async {
    var employee = ref.read(authViewModel).loginResponse?.employee;
    var isEmployee = employee != null;

    var res = await ref.read(inventoryViewModel).getProducts(
      isEmployee: isEmployee,
      branchId: employee?.branch
    );

    if(res != null) {
      _products = res.products;
      notifyListeners();
    }
  }

  Future<void> getCategories() async {
    var employee = ref.read(authViewModel).loginResponse?.employee;
    var isEmployee = employee != null;

    var res = await ref.read(inventoryViewModel).getCategories(
      isEmployee: isEmployee,
      branchId: employee?.branch
    );
    
    if(res != null) {
      resetCategory();
      _categories = [
        Category(
          name: "All Products",
          id: ""
        )
      ];
      notifyListeners();
      _categories.addAll(res.categories!);
      _categoryItems = populateItems();
      notifyListeners();
    }
  }

  Future<void> getProductsByCategory({String? id}) async {
    var res = await ref.read(inventoryViewModel).getProductsByCategory(categoryId: id);
    if(res != null) {
      _products = res.products ?? [];
      notifyListeners();
    }
  }

  void onCategoryChanged(Category? v) async {
    _selectedCategory = v;
    notifyListeners();

    if(v?.name == "All Products") {
      await getProducts();
    } else {
      await getProductsByCategory(id: v?.id);
    }
  }

  List<DropdownMenuItem<Category>> populateItems() {
    var brightness = Theme.of(navigatorKey.currentContext!).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    List<DropdownMenuItem<Category>> menu = _categories.map((e) {
      return DropdownMenuItem<Category>(
        value: e,
        child: Theme(
          data: Theme.of(navigatorKey.currentContext!).copyWith(
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: isDarkMode ? Colors.white : ColorPalette.textColor
              )
            )
          ),
          child: Text(
            e.name!,
            style: Theme.of(navigatorKey.currentContext!).textTheme.bodyText1,
          ),
        ),
      );
    }).toList();

    return menu;
  }
  
}