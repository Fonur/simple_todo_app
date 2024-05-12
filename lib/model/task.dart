import 'dart:ffi';

class Task {
  final int? id;
  late final String taskName;
  late bool done;

  Task({this.id, required this.taskName, this.done = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskName': taskName,
      'done': done ? 1 : 0
    };
  }
}
