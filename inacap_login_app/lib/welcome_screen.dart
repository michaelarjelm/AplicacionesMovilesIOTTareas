import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String userEmail;

  const WelcomeScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        backgroundColor: Color.fromARGB(255, 145, 45, 38),
        foregroundColor: const Color.fromARGB(255, 221, 165, 165),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido a su cuenta',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Bienvenido,',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              userEmail,
              style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
