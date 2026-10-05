import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/tudee_header.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  EditTaskScreen({required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController taskController = TextEditingController();
  bool isDone = false;

  @override
  void initState() {
    super.initState();

    taskController.text = widget.task.title;
    isDone = widget.task.isDone;
  }

  void saveChanges() {
    String title = taskController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a task'),
        ),
      );
      return;
    }

    Task updatedTask = Task(
      title: title,
      isDone: isDone,
    );

    Navigator.pop(context, updatedTask);
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBE7E8),
      appBar: TudeeHeader(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Edit Task',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                Icon(
                  Icons.edit_note,
                  color: Color(0xFF111827),
                  size: 24,
                ),
              ],
            ),
            SizedBox(height: 32),
            TextField(
              controller: taskController,
              minLines: 2,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF111827),
              ),
              decoration: InputDecoration(
                hintText: 'What needs to be done?',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF667085),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isDone = false;
                    });
                  },
                  icon: Icon(
                    Icons.pending_actions,
                    size: 18,
                  ),
                  label: Text('To Do'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDone
                        ? Color(0xFFD5CCFC)
                        : Color(0xFF9B86F8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isDone = true;
                    });
                  },
                  icon: Icon(
                    Icons.task_alt,
                    size: 18,
                  ),
                  label: Text('Done'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDone
                        ? Color(0xFF76C499)
                        : Color(0xFFB8D9C4),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF49BAF2),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text(
                  'Save changes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}