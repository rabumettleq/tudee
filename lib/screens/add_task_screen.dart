import 'package:flutter/material.dart';
import '../widgets/tudee_header.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController taskController = TextEditingController();

  void saveTask() {
    String title = taskController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a task'),
        ),
      );
      return;
    }

    Navigator.pop(context, title);
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
                  'Add Task',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                Icon(
                  Icons.note_add_outlined,
                  color: Color(0xFF111827),
                  size: 24,
                ),
              ],
            ),
            SizedBox(height: 32),
            TextField(
              controller: taskController,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                saveTask();
              },
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
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF49BAF2),
                    Color(0xFF3A9CCD),
                  ],
                ),
              ),
              child: ElevatedButton(
                onPressed: saveTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text(
                  'Save',
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