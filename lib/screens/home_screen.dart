import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/tudee_header.dart';
import '../widgets/task_stats_card.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';
import '../widgets/empty_tasks_card.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  HomeScreen({required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  Future<void> addTask() async {
    String? title = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(),
      ),
    );

    if (!mounted || title == null) {
      return;
    }

    setState(() {
      tasks.add(Task(title: title));
    });
  }

  Future<void> editTask(Task task) async {
    Task? updatedTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(task: task),
      ),
    );

    if (!mounted || updatedTask == null) {
      return;
    }

    setState(() {
      task.title = updatedTask.title;
      task.isDone = updatedTask.isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    int doneCount = tasks.where((task) => task.isDone).length;
    int todoCount = tasks.length - doneCount;

    return Scaffold(
      backgroundColor: Color(0xFFFBE7E8),
      appBar: TudeeHeader(),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 360),
          child: ListView(
            padding: EdgeInsets.fromLTRB(16, 32, 16, 96),
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome ${widget.name}',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: 24 / 20,
                        color: Color(0xDE1F1F1F),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TaskStatsCard(
                            title: 'Done',
                            count: doneCount,
                            color: Color(0xFF76C499),
                            icon: Icons.task_alt,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: TaskStatsCard(
                            title: 'To-Do',
                            count: todoCount,
                            color: Color(0xFF9887F5),
                            icon: Icons.pending_actions,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              if (tasks.isEmpty) EmptyTasksCard(),
              ...tasks.map((task) {
                return TaskCard(
                  task: task,
                  onTap: () {
                    editTask(task);
                  },
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF49BAF2),
              Color(0xFF3A9CCD),
            ],
          ),
        ),
        child: FloatingActionButton(
          onPressed: addTask,
          backgroundColor: Colors.transparent,
          foregroundColor: Color(0xDEFFFFFF),
          elevation: 0,
          focusElevation: 0,
          hoverElevation: 0,
          highlightElevation: 0,
          shape: CircleBorder(),
          child: Icon(
            Icons.note_add_outlined,
            size: 24,
          ),
        ),
      ),

    );
  }
}