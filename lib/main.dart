import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatefulWidget {
  StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String? savedName;

  @override
  void initState() {
    super.initState();
    loadName();
  }

  Future<void> loadName() async {
    final prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString('user_name');

    if (!mounted) {
      return;
    }

    setState(() {
      savedName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (savedName == null) {
      return WelcomeScreen();
    }

    return HomeScreen(name: savedName!);
  }
}