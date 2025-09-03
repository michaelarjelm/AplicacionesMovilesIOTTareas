import '../models/task.dart';

class TaskController
{
    final List<Task> _tasks = [
        Task(
            title: "Revisar las evaluaciones de App Movil",
            note: "Poner puros 7",
            due: DateTime.now().add(const Duration(days: 1)),
        ),
        Task(
            title: "Ir a comprar pancito",
            note: "De preferencia pan amasado porque si no es malo",
            due: DateTime.now().add(const Duration(days: 1)),
        ),
        Task(
            title: "Hacer la cama comiendo hamburguesas",
            note: "Tener cuidado con manhar",
            due: DateTime.now().add(const Duration(days: 1)),
        ),
    ];
    String _query="";

    TaskFilter _filter = TaskFilter.all;

    List<Task> get task=> List.unmodifiable(_tasks);

    String get query=> _query;

    List<Task> get filtered {
        final q=_query.trim().toLowerCase();
        return _tasks.where((t) {
            final byFilter = switch(_filter){
                TaskFilter.all => true,
                TaskFilter.pending=>!t.done,
                TaskFilter.done=>t.done
            };

            final byQuery =q.isEmpty|| t.title.toLowerCase().contains(q) || (t.note?.toLowerCase().contains(q) ?? false);
            return byFilter && byQuery;
        }).toList();
    }
};