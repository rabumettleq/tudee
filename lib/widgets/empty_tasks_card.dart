import 'package:flutter/material.dart';

class EmptyTasksCard extends StatelessWidget {
  const EmptyTasksCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            offset: Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No tasks for today!',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 20 / 16,
              color: Color(0xDE1F1F1F),
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Tap the + button to add your first one.',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 17 / 14,
              color: Color(0x991F1F1F),
            ),
          ),
        ],
      ),
    );
  }
}