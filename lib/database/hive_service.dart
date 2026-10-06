import 'package:hive_ce_flutter/hive_flutter.dart';
import '../models/task.dart';

class HiveService {
  static String boxName = 'task';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  Box get box => Hive.box(boxName);

// Add Task
  Future<void> addTask(Task task) async {
    await box.add({
      'title': task.title,
      'isDone': task.isDone,
    });
  }
// Get Tasks
  List<Task> getTasks() {
    List<Task> tasks = [];

    for (int i = 0; i < box.length; i++) {
      final data = box.getAt(i);

      tasks.add(
        Task(
          title: data['title'],
          isDone: data['isDone'],
        ),
      );
    }

    return tasks;
  }

// Update Task
  Future<void> updateTask(int index, Task task) async {
    await box.putAt(index, {
      'title': task.title,
      'isDone': task.isDone,
    });
  }
// Delete Task
  Future<void> deleteTask(int index) async {
    await box.deleteAt(index);
  }
}