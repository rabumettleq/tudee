import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/tudee_header.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController nameController = TextEditingController();
  bool isSaving = false;

  Future<void> saveName() async {
    if (isSaving) {
      return;
    }

    String name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your name'),
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      isSaving = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      bool saved = await prefs.setString('user_name', name);

      if (!mounted) {
        return;
      }

      if (!saved) {
        throw Exception('Name was not saved');
      }
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not save your name. Please try again.'),
        ),
      );
      return;
    }

    if (!mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(name: name),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBE7E8),
      appBar: TudeeHeader(),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 360),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 38),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 36,
                        child: Text(
                          "Let's get started",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            height: 1,
                            color: Color(0xFF111827),
                          ),
                        ),
                      ),
                      SizedBox(height: 26),
                      SizedBox(
                        height: 19,
                        child: Text(
                          'What should we call you?',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1,
                            color: Color(0xFF667085),
                          ),
                        ),
                      ),
                      SizedBox(height: 19),
                      SizedBox(
                        height: 56,
                        child: TextField(
                          controller: nameController,
                          enabled: !isSaving,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.done,
                          textAlignVertical: TextAlignVertical.center,
                          onSubmitted: (value) {
                            saveName();
                          },
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1,
                            color: Color(0xFF111827),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Your name',
                            hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 1,
                              color: Color(0xFF667085),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 17,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xFFD1D6DE),
                                width: 1,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xFFD1D6DE),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xFF49BAF2),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 14, right: 18),
                  child: Container(
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
                      onPressed: isSaving ? null : saveName,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        disabledBackgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Color(0xDEFFFFFF),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Text(
                        isSaving ? 'Saving...' : 'Save',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 19 / 16,
                          color: Color(0xDEFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}