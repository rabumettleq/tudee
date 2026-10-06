import 'package:flutter/material.dart';
import '../database/hive_service.dart';
import '../models/task.dart';
import '../widgets/tudee_header.dart';
import '../widgets/task_stats_card.dart';
import '../widgets/empty_tasks_card.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  const HomeScreen({super.key, required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HiveService hiveService = HiveService();
  List<Task> tasks = [];
  bool isChangingStatus = false;

  @override
  void initState() {
    super.initState();
    tasks = hiveService.getTasks();
  }

  void loadTasks() {
    setState(() {
      tasks = hiveService.getTasks();
    });
  }

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

    await hiveService.addTask(Task(title: title));

    if (!mounted) {
      return;
    }

    loadTasks();
  }

  Future<void> editTask(int index) async {
    if (isChangingStatus) {
      return;
    }

    Task? updatedTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(
          task: tasks[index],
        ),
      ),
    );

    if (!mounted || updatedTask == null) {
      return;
    }

    await hiveService.updateTask(index, updatedTask);

    if (!mounted) {
      return;
    }

    loadTasks();
  }

  Future<void> toggleTaskStatus(int index) async {
    if (isChangingStatus) {
      return;
    }

    isChangingStatus = true;

    Task updatedTask = Task(
      title: tasks[index].title,
      isDone: !tasks[index].isDone,
    );

    try {
      await hiveService.updateTask(index, updatedTask);

      if (!mounted) {
        return;
      }

      loadTasks();
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not update task status. Please try again.'),
        ),
      );
    } finally {
      isChangingStatus = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    int doneCount = tasks.where((task) => task.isDone).length;
    int todoCount = tasks.length - doneCount;

    return Scaffold(
      backgroundColor: Color(0xFFFCE8E8),
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
                            imagePath: 'assets/icons/Done-Vector.png',
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: TaskStatsCard(
                            title: 'To-Do',
                            count: todoCount,
                            color: Color(0xFF9887F5),
                            imagePath: 'assets/icons/ToDo-Vector.png',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              if (tasks.isEmpty) EmptyTasksCard(),
              for (int i = 0; i < tasks.length; i++)
                TaskCard(
                  task: tasks[i],
                  onTap: () {
                    editTask(i);
                  },
                  onStatusTap: () {
                    toggleTaskStatus(i);
                  },
                ),
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
          child: Image.asset(
            'assets/icons/add-icon.png',
            width: 28,
            height: 28,
            fit: BoxFit.contain,
            color: Color(0xDEFFFFFF),
          ),
        ),
      ),
    );
  }
}