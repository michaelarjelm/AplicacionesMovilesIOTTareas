import 'package:flutter/material.dart';
import 'screens/login_screen.dart';


void main() {
  runApp(const MyApp());
}

//Widget raíz de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      const Color inacapRed = Color(0xFFE30513);

    return MaterialApp(
      title: 'Evaluación 1',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: inacapRed,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: inacapRed,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: inacapRed,
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),   // Texto de label en blanco
          hintStyle: TextStyle(color: Colors.white70), // Hint en gris clarito
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Borde blanco cuando NO está enfocado
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),   // Borde rojo al enfocar
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Texto dentro del TextField
        ),
      ),

      home: const LoginScreen(),
    );
  }
}
