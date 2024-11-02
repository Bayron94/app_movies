import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_app_2024/config/router/app_router.dart';
import 'package:test_app_2024/config/theme/app_theme.dart';
import 'injection_container.dart' as di;

void main() async {
  await dotenv.load(fileName: '.env');
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );

    /* return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => authenticationProvider,
        )
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
      ),
    ); */
  }
}
