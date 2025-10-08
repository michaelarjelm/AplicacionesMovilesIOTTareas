// Importa utilidades de Flutter (como ChangeNotifier)
import 'package:app_tareas/repositories/task_repository.dart';
import 'package:flutter/foundation.dart';
// Importa el modelo de datos de tareas
import '../models/task.dart';

// Controlador que maneja la lista de tareas y la lógica
class TaskController extends ChangeNotifier {
  TaskController({TaskRepository? repo}) : _repo = repo ?? TaskRepository();
  final TaskRepository _repo;
  // Lista privada de tareas iniciales (3 de ejemplo)
  final List<Task> _tasks = [];

  final Map<Task, String> _idByTask = {};

  // Texto para búsqueda
  String _query = '';
  // Filtro actual (todas, pendientes o completadas)
  TaskFilter _filter = TaskFilter.all;

  // ----- Lecturas (getters) -----

  // Devuelve la lista de tareas, pero como lista de solo lectura
  List<Task> get tasks => List.unmodifiable(_tasks);

  // Devuelve el texto de búsqueda actual
  String get query => _query;

  // Devuelve el filtro actual
  TaskFilter get filter => _filter;

  // Devuelve la lista de tareas filtradas por búsqueda y filtro
  List<Task> get filtered {
    final q = _query.trim().toLowerCase(); // texto de búsqueda en minúsculas
    return _tasks.where((t) {
      // Filtra por estado
      final byFilter = switch (_filter) {
        TaskFilter.all => true, // todas
        TaskFilter.pending => !t.done, // solo no completadas
        TaskFilter.done => t.done, // solo completadas
      };
      // Filtra por coincidencia con el texto
      final byQuery =
          q.isEmpty ||
          t.title.toLowerCase().contains(q) ||
          (t.note?.toLowerCase().contains(q) ?? false);

      // La tarea pasa si cumple ambos filtros
      return byFilter && byQuery;
    }).toList();
  }

  Future<void> load() => _reloadFromRepository();

  Future<void> _reloadFromRepository() async {
    final rows = await _repo.findFiltered(filter: filter, query: query);
    _tasks
      ..clear()
      ..addAll(rows.map((r) => r.task));

    _idByTask
      ..clear()
      ..addEntries(rows.map((r) => MapEntry(r.task, r.id)));
    notifyListeners();
  }

  // Cambia el texto de búsqueda
  void setQuery(String value) {
    _query = value;
    _reloadFromRepository(); // avisa a la interfaz de usuario (UI) que hubo un cambio, para que se vuelva a redibujar.
  }

  // Cambia el filtro de tareas
  void setFilter(TaskFilter f) {
    _filter = f;
    _reloadFromRepository();
  }

  // Marca o desmarca una tarea como completada
  Future<void> toggle(Task task, bool v) async {
    final id = _idByTask[task];
    if (id == null) {
      await _reloadFromRepository();
      return;
    }
    await _repo.setDone(id, v);

    notifyListeners();
  }

  // Agrega una nueva tarea al inicio de la lista
  void add(String title, {String? note, DateTime? due}) async {
    final task = Task(title: title, note: note, due: due);
    await _repo.create(task);
    _reloadFromRepository();
  }

  // Elimina una tarea de la lista
  Future<void> remove(Task task) async {
    final id = _idByTask[task];
    if (id == null) {
      await _reloadFromRepository();
      return;
    }
    await _repo.delete(id);

    _reloadFromRepository();
  }
}
