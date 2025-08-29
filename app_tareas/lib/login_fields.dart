import 'package:flutter/material.dart'; // Importa las herramientas visuales de Flutter

// Define un widget con estado (porque hay campos que cambian, como contraseña oculta o cargando)
class LoginFields extends StatefulWidget {
  const LoginFields({super.key}); // Constructor del widget con clave opcional

  @override
  State<LoginFields> createState() => _LoginFieldsState(); // Crea el estado del widget
}

class _LoginFieldsState extends State<LoginFields> {
  final _formKey = GlobalKey<FormState>(); // Llave para manejar el formulario y validaciones
  final _emailCtrl = TextEditingController(); // Controlador para el campo de email
  final _passCtrl = TextEditingController(); // Controlador para el campo de contraseña

  bool _obscure = true; // Para ocultar o mostrar la contraseña
  bool _loading = false; // Para indicar si está cargando (ej. al enviar el formulario)
  String? _error; // Para guardar y mostrar un posible mensaje de error

  @override
  void dispose() {
    // Libera los recursos de los controladores cuando el widget se destruye
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // Lógica para enviar el formulario
    FocusScope.of(context).unfocus(); // Oculta el teclado
    final ok = _formKey.currentState?.validate() ?? false; // Valida los campos
    if (ok) return; // Si está todo bien, aquí se podría seguir (por ahora no hace nada más)
  }

  @override
  Widget build(BuildContext context) {
    // Construye la parte visual del widget
    return AutofillGroup( // Agrupa campos que permiten autocompletar
      child: Form(
        key: _formKey, // Usa la llave definida antes para validar
        autovalidateMode: AutovalidateMode.onUserInteraction, // Valida automáticamente mientras el usuario escribe
        child: Column( // Organiza los widgets en una columna
          crossAxisAlignment: CrossAxisAlignment.stretch, // Estira el contenido horizontalmente
          mainAxisSize: MainAxisSize.min, // Ocupa el mínimo espacio necesario
          children: [
            Center( // Centra la imagen
              child: Image.network(
                "https://i.ibb.co/gbM1xQbB/logo-inacap.jpg", // Logo de Inacap
                height: 100,
                fit: BoxFit.contain, // Ajusta la imagen sin recortarla
              ),
            ),
            const SizedBox(height: 16), // Espacio vertical

            const Text(
              "Bienvenido Inacapino", // Mensaje de bienvenida
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600), // Estilo del texto
              textAlign: TextAlign.center, // Centra el texto
            ),

            TextFormField( // Campo de texto para el email
              enabled: _loading, // Está deshabilitado si _loading es falso (esto parece un error lógico, debería ser !loading)
              controller: _emailCtrl, // Controlador del campo
              keyboardType: TextInputType.emailAddress, // Tipo de teclado: correo electrónico
              textCapitalization: TextCapitalization.none, // No capitaliza automáticamente
              autocorrect: false, // No corrige automáticamente
              enableSuggestions: true, // Permite sugerencias del teclado
              autofillHints: const [AutofillHints.email], // Sugerencia para autocompletar email
              decoration: const InputDecoration(
                labelText: "Email", // Etiqueta del campo
                hintText: "ejemplo@ejemplo.com", // Texto de ayuda
                prefixIcon: Icon(Icons.email_outlined), // Ícono al inicio
                border: OutlineInputBorder(), // Borde alrededor del campo
              ),
            )
          ],
        ),
      ),
    );
  }
}
