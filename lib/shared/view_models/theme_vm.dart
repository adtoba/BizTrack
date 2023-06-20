import 'package:flutter/material.dart';


class ThemeViewModel extends ChangeNotifier {
  late BuildContext context;

  ThemeViewModel(BuildContext ctx) {
    context = ctx;
  }

  bool get isDarkMode {
    var brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark;
  }
  
}