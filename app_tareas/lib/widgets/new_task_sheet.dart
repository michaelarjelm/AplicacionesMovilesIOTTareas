// Importa el paquete de Flutter con widgets Material
import 'package:flutter/material.dart';

// Widget de formulario para crear una nueva tarea
class NewTaskSheet extends StatefulWidget {
  const NewTaskSheet({super.key, required this.onSubmit});
  // Función que se ejecuta cuando se envía el formulario
  final void Function(String title, String? note) onSubmit;

  @override
  State<NewTaskSheet> createState() => _NewTaskSheetState();
}

// Estado del formulario de nueva tarea
class _NewTaskSheetState extends State<NewTaskSheet> {
  // Llave global para validar el formulario
  final _formKey = GlobalKey<FormState>();
  // Controlador para el campo de título
  final _titleCtrl = TextEditingController();
  // Controlador para el campo de notas
  final _noteCtrl = TextEditingController();

  @override
  void dispose() {
    // Libera la memoria de los controladores cuando se destruye el widget
    _titleCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Widget que representa el formulario
    return Form(
      key: _formKey, // asocia la clave al formulario
      child: Column(
        mainAxisSize: MainAxisSize.min, // se ajusta al contenido
        children: [
          // Título del formulario
          const Text(
            'Nueva tarea',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12), // espacio vertical

          // Campo para ingresar el título de la tarea
          TextFormField(
            controller: _titleCtrl, // conecta al controlador de título
            autofocus: true,         // abre el teclado automáticamente
            textInputAction: TextInputAction.next, // botón "siguiente"
            decoration: const InputDecoration(
              labelText: 'Título', // etiqueta visible
              hintText: 'Ej: Preparar guía de ejercicios', // texto de ayuda
              prefixIcon: Icon(Icons.title), // ícono a la izquierda
              border: OutlineInputBorder(),   // borde cuadrado
              filled: true,                   // fondo con color
            ),
            // Valida que el título no esté vacío
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'Ingrese un título'
                : null,
          ),
          const SizedBox(height: 12),

          // Campo para ingresar notas opcionales
          TextFormField(
            controller: _noteCtrl, // conecta al controlador de notas
            maxLines: 3,           // permite varias líneas
            decoration: const InputDecoration(
              labelText: 'Notas (opcional)',   // etiqueta visible
              prefixIcon: Icon(Icons.note_outlined), // ícono de nota
              border: OutlineInputBorder(),
              filled: true,
            ),
          ),
          const SizedBox(height: 16),

          // Botón para crear la tarea
          SizedBox(
            width: double.infinity, // ocupa todo el ancho
            height: 48,             // altura fija
            child: FilledButton.icon(
              onPressed: () {
                // Si el formulario no es válido, no hace nada
                if (!_formKey.currentState!.validate()) return;

                // Obtiene el texto del título y nota
                final title = _titleCtrl.text.trim();
                final note = _noteCtrl.text.trim();

                // Llama a la función recibida (onSubmit)
                // Si la nota está vacía, se manda como null
                widget.onSubmit(title, note.isEmpty ? null : note);
              },
              icon: const Icon(Icons.check),   // ícono de check
              label: const Text('Crear'),      // texto del botón
            ),
          ),
        ],
      ),
    );
  }
}
