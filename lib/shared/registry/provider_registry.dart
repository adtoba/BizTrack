import 'package:biz_track/features/auth/view_models/auth_vm.dart';
import 'package:biz_track/features/inventory/view_models/cart_vm.dart';
import 'package:biz_track/features/inventory/view_models/inventory_vm.dart';
import 'package:biz_track/main.dart';
import 'package:biz_track/shared/view_models/theme_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final themeViewModel = ChangeNotifierProvider((ref) => ThemeViewModel(navigatorKey.currentContext!));
final authViewModel = ChangeNotifierProvider((ref) => AuthVm());
final inventoryViewModel = ChangeNotifierProvider((ref) => InventoryVm());
final cartViewModel = ChangeNotifierProvider((ref) => CartVm());