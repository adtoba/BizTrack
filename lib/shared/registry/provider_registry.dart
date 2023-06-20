import 'package:biz_track/main.dart';
import 'package:biz_track/shared/view_models/theme_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final themeViewModel = ChangeNotifierProvider((ref) => ThemeViewModel(navigatorKey.currentContext!));