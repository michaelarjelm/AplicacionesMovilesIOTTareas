import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {

  final String userEmail;

  // El constructor. 
  const WelcomeScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido/a'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
          children: [
            const Text(
              '🎉 ¡Login Exitoso! 🎉',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              //  Mensaje de bienvenida personalizado
              'Bienvenido/a,',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              userEmail, // ¡Aquí mostramos el email que recibimos!
              style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}