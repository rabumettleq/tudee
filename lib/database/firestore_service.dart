import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService {
  final tasks = FirebaseFirestore.instance.collection('tasks');

  // Add Task
  Future<void> addTask(Task task) async {
    await tasks.add({
      'title': task.title,
      'isDone': task.isDone,
    });
  }

  // Get Tasks
  Stream<List<Task>> getTasks() {
    return tasks.snapshots().map((snapshot) {
      List<Task> taskList = [];

      for (final document in snapshot.docs) {
        final data = document.data();

        taskList.add(
          Task(
            id: document.id,
            title: data['title'],
            isDone: data['isDone'],
          ),
        );
      }

      return taskList;
    });
  }
  // Update Task
  Future<void> updateTask(String id, Task task) async {
    await tasks.doc(id).update({
      'title': task.title,
      'isDone': task.isDone,
    });
  }

  // Delete Task
  Future<void> deleteTask(String id) async {
    await tasks.doc(id).delete();
  }
}