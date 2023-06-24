import 'dart:io';

import 'package:intl/intl.dart';

String parseAmount(String? amount) {
  // RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  // // ignore: prefer_function_declarations_over_variables
  // String Function(Match) mathFunc = (Match match) => '${match[1]},';

  // var result = amount?.replaceAllMapped(reg, mathFunc);
  NumberFormat myFormat = NumberFormat.decimalPattern("en_us");

  return myFormat.format(double.tryParse(amount!.replaceAll(",", "")));
}

String currency() {
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: "NGN");
    return format.currencySymbol;
}