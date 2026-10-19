class Task {
  String? id;
  String title;
  bool isDone;

  Task({
    this.id,
    required this.title,
    this.isDone = false,
  });
}