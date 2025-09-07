import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/main_wrapper.dart';
import 'core/constants/app_strings.dart';
import 'core/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      routerConfig: appRouter,
      builder: (context, child) {
        return const MainWrapper(); 
      },
    );
  }
}
