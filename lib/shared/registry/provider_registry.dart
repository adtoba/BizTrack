import 'package:biz_track/features/auth/view_models/auth_vm.dart';
import 'package:biz_track/features/branch/view_models/branch_vm.dart';
import 'package:biz_track/features/cashier/view_models/dashboard_vm.dart';
import 'package:biz_track/features/customer/view_models/customer_vm.dart';
import 'package:biz_track/features/employees/view_models/employee_vm.dart';
import 'package:biz_track/features/inventory/view_models/cart_vm.dart';
import 'package:biz_track/features/inventory/view_models/inventory_vm.dart';
import 'package:biz_track/features/order/view_models/order_vm.dart';
import 'package:biz_track/main.dart';
import 'package:biz_track/shared/view_models/theme_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final themeViewModel = ChangeNotifierProvider((ref) => ThemeViewModel(navigatorKey.currentContext!));
final authViewModel = ChangeNotifierProvider((ref) => AuthVm(ref));
final inventoryViewModel = ChangeNotifierProvider((ref) => InventoryVm(ref));
final cartViewModel = ChangeNotifierProvider((ref) => CartVm(ref));
final orderViewModel = ChangeNotifierProvider((ref) => OrderVm(ref));
final customerViewModel = ChangeNotifierProvider((ref) => CustomerVm(ref));
final branchViewModel = ChangeNotifierProvider((ref) => BranchVm());
final employeeViewModel = ChangeNotifierProvider((ref) => EmployeeViewModel());
final cashierDashboardViewModel = ChangeNotifierProvider((ref) => CashierDashboardVm(ref));