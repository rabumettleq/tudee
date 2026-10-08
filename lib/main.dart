import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database/hive_service.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String? savedName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadName();
  }

  Future<void> loadName() async {
    final prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('user_name')?.trim();

    if (!mounted) {
      return;
    }

    setState(() {
      savedName = name;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Color(0xFFFCE8E8),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF49BAF2),
          ),
        ),
      );
    }

    if (savedName == null || savedName!.isEmpty) {
      return WelcomeScreen();
    }

    return HomeScreen(name: savedName!);
  }
}