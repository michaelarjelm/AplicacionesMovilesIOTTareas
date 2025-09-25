import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Una "llave" global para identificar nuestro formulario
  final _formKey = GlobalKey<FormState>();

  // Controladores para leer el texto de los campos de email y contraseña.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Esta función se ejecuta cuando el widget es destruido.

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _ingresar() {


    final esValido = _formKey.currentState?.validate() ?? false;

    if (esValido) {

      print(" ¡Formulario Válido!");
      print("Email: ${_emailController.text}");
      

    } else {

      print(" ¡Formulario Inválido!");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold es la estructura básica de una pantalla (barra superior, cuerpo, etc.)
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login INACAP'),
        backgroundColor: Colors.red, //  Estilo corporativo
        foregroundColor: Colors.white,
      ),
      body: Center( // Centra el contenido
        child: SingleChildScrollView( 
          padding: const EdgeInsets.all(16.0), 
          child: Form(
            key: _formKey, 
            child: Column( //  columna vertical
              mainAxisSize: MainAxisSize.min, 
              children: [
                // --- CAMPO DE CORREO ELECTRÓNICO (RF1, RF2) ---
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                    hintText: 'tu.correo@inacapmail.cl',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, ingresa tu correo'; 
                    }
                    if (!value.contains('@')) {
                      return 'El correo debe contener un @'; 
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16), 

                // --- CAMPO DE CONTRASEÑA ---
                TextFormField(
                  controller: _passwordController,
                  obscureText: true, // Oculta el texto de la contraseña
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa tu contraseña';
                    }
                    if (value.length < 6) {
                      return 'La contraseña debe tener al menos 6 caracteres'; 
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // --- BOTÓN DE INGRESO ---
                SizedBox(
                  width: double.infinity, // Hace que el botón ocupe todo el ancho
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _ingresar, // Llama a nuestra función al presionar
                    child: const Text('Ingresar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}