import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  //Variable final para almacenar el correo electrónico recibido.
  final String email;

  //Constructor requiere que se le pase el email al crear el widget.
  const WelcomeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido/a'),
        centerTitle: true,
        //no se necesita botón de regreso porque reemplazamos la pantalla de login.
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¡Login exitoso!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              //mensaje de bienvenida personalizado con el email.
              Text(
                'Bienvenido, $email',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}