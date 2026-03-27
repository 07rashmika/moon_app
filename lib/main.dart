import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moon_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:moon_app/firebase_options.dart';
import 'package:moon_app/themes/dark_mode.dart';
import 'package:moon_app/themes/light_mode.dart';

void main() async {
  //firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
