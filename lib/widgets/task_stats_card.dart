import 'package:flutter/material.dart';

class TaskStatsCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final IconData icon;

  TaskStatsCard({
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 118,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0x3DFFFFFF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color(0x1FFFFFFF),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              size: 24,
              color: Color(0xDEFFFFFF),
            ),
          ),
          SizedBox(height: 8),
          Text(
            '$count',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              height: 28 / 24,
              color: Color(0xDEFFFFFF),
            ),
          ),
          SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 16 / 12,
              color: Color(0xB3FFFFFF),
            ),
          ),
        ],
      ),
    );
  }
}