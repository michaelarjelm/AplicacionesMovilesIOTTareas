import 'package:flutter/material.dart';
import 'welcome_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Clave global para identificar y manejar el estado del formulario.
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  
  void _login() {
      //Si todos los validadores retornan 'null', el formulario es válido.
    if (_formKey.currentState!.validate()) {
      String userEmail = _emailController.text;

      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          
          builder: (context) => WelcomeScreen(email: userEmail),
        ),
      );
    }
  }

  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey, //clave al formulario.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                 Center(
                    child: Image.network(
                      'https://play-lh.googleusercontent.com/c5cvYpLLDFDLFqyHqtf_GzR0sYpXUs19zt7FmPT5pCHcPRqylSU_TgaHZLF2g8iUGGA_', 
                      height: 150,                                  
                      fit: BoxFit.contain,                          //ajuste para que no se deforme
                    ),
                  ),
                  const SizedBox(height: 80), //espacio debajo de la imagen
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo Electrónico',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    //Lógica de validación para el correo.
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor, ingresa tu correo';
                      }
                      //Validar que contenga '@'.
                      if (!value.contains('@')) {
                        return 'El formato del correo no es válido';
                      }
                      return null; //retornar null significa que la validación pasó.
                    },
                  ),
                  const SizedBox(height: 20),

                  
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true, //oculta el texto de la contraseña.
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    //Validación contraseña.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu contraseña';
                      }
                      //Validar mínimo de 6 caracteres.
                      if (value.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  
                  ElevatedButton(
                    onPressed: _login, //Llama a la función _login al ser presionado.
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('Ingresar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}