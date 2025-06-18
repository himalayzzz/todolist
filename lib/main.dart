import 'package:flutter/material.dart';
import 'package:todo_project/presentation/splash_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: SplashScreen(),
      );
  }
}
