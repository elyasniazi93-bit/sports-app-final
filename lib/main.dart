import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // متصل به صفحه خوش‌آمدگویی

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sports App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
      ),
      home: const SplashScreen(), // شروع مستقیم با اسپلش اسکرین
    );
  }
}
