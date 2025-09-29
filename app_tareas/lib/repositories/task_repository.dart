import 'package:app_tareas/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskRepository {
  TaskRepository({FirebaseFirestore? db, String collectionPath = "tasks"})
    : _db = db ?? FirebaseFirestore.instance,
      _collectionPath = collectionPath;

  final FirebaseFirestore _db;
  final String _collectionPath;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection(_collectionPath);

  Future<String> create(Task t) async {
    final titleTrim = t.title.trim();

    final document = await _col.add({
      "title": titleTrim,
      "done": t.done,
      "title_lc": titleTrim.toLowerCase(),

      if ((t.note?.trim().isNotEmpty ?? false)) "note": t.note!.trim(),
      if (t.due != null) "due": Timestamp.fromDate(t.due!),
      "createdAt": FieldValue.serverTimestamp(),
    });
    return document.id;
  }

  Future<List<({String id, Task task})>> findAll() async {
    final snap = await _col.orderBy("createdAt", descending: true).get();
    return snap.docs.map((d) => (id: d.id, task: _fromDoc(d))).toList();
  }

  Future<List<({String id, Task task})>> findFiltered({
    required TaskFilter filter,
    required String query,
  }) async {
    Query<Map<String, dynamic>> q = _col;

    switch (filter) {
      case TaskFilter.pending:
        q = q.where("done", isEqualTo: false);
        break;
      case TaskFilter.done:
        q = q.where("done", isEqualTo: true);
        break;
      case TaskFilter.all:
        break;
    }

    final text = query.trim().toLowerCase();
    if (text.isNotEmpty) {
      q = q.orderBy("title_lc").startAt([text]).endAt(['$text\uf8ff']);
    } else {
      q = q.orderBy("createdAt", descending: true);
    }
    final snap = await q.get();

    return snap.docs.map((d) => (id: d.id, task: _fromDoc(d))).toList();
  }
}

Task _fromDoc(DocumentSnapshot<Map<String, dynamic>> d) {
  final data = d.data() ?? const <String, dynamic>{};
  return Task(
    title: (data["title"] as String?)?.trim() ?? "",
    done: (data["done"] as bool?) ?? false,
    note: data["note"] as String?,
    due: (data["due"] is Timestamp)
        ? (data["due"] as Timestamp).toDate()
        : null,
  );
}
