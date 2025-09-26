import 'package:flutter/material.dart';
import 'package:inacap_login_app/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login  Inacap',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 192, 60, 51)),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 56, 15, 12),
            foregroundColor: const Color.fromARGB(255, 240, 235, 235),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
