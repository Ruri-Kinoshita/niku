import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/constant/app_color.dart';
import 'package:niku/round1/roulette1.dart';
import 'package:niku/router.dart';
import 'package:niku/round1/timer.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.brand.primary),
        useMaterial3: true,
      ),
      routerConfig: router, // ルーター設定
    );
  }
}
