import 'package:biz_track/features/auth/views/welcome_view.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      darkTheme: CustomTheme.darkTheme,
      theme: CustomTheme.lightTheme,
      home: Builder(
        builder: (context) {
          SizeConfig.init(context);
          return const WelcomeView();
        }
      ),
    );
  }
}

