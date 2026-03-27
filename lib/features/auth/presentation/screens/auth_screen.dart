import 'package:flutter/material.dart';
import 'package:moon_app/features/auth/presentation/screens/login_screen.dart';
import 'package:moon_app/features/auth/presentation/screens/register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLoggingPage = true;

  void togglePages() {
    setState(() {
      showLoggingPage = !showLoggingPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoggingPage
        ? LoginScreen(togglePages: togglePages)
        : RegisterScreen(togglePages: togglePages);
  }
}
