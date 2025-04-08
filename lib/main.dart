import 'package:fitness_app/global/global-config.dart';
import 'package:fitness_app/module/auth/welcome-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'module/widgets/CTabBar.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: GlobalConfig.primaryColor,
          )),
      // TODO: login kontrolü
      //home: isLoggedIn ? CTabbar() : const WelcomeScreen(),
      home: CTabbar(),
    );
  }
}
