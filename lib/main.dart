import 'package:biz_track/features/auth/views/splash_view.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("app_data");
  
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
      theme: CustomTheme.lightTheme,
      home: Builder(
        builder: (context) {
          SizeConfig.init(context);
          return const SplashView();
        }
      ),
    );
  }
}

