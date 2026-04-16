import 'package:flutter/material.dart';
import 'package:unitask/app/router/app_router.dart';
import 'package:unitask/app/theme/app_theme.dart';

void main() {
  runApp(const uniTaskApp());
}

class uniTaskApp extends StatelessWidget {
  const uniTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'uniTaskApp',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
