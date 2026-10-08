import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onStatusTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 111,
        margin: EdgeInsets.only(bottom: 14),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0x0D000000),
              offset: Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 28,
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: onStatusTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: task.isDone
                          ? Color(0xFF76C499)
                          : Color(0xFF9887F5),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      task.isDone ? 'Done' : 'TODO',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 16 / 12,
                        color: Color(0xDEFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              task.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 24 / 20,
                color: Color(0xDE1F1F1F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}