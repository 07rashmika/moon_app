import 'package:flutter/material.dart';
import 'package:moon_app/features/auth/presentation/components/my_button.dart';
import 'package:moon_app/features/auth/presentation/components/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? togglePages;

  const LoginScreen({super.key, required this.togglePages});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const .symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Icon(
                Icons.lock_open,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 25),

              //app name
              Text(
                "build, launch & monetize".toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  letterSpacing: 6,
                ),
              ),

              const SizedBox(height: 25),

              //email textfield
              MyTextfield(
                controller: emailController,
                hintText: 'yourname@domain.com',
                obscureText: false,
              ),

              const SizedBox(height: 25),

              MyTextfield(
                controller: passwordController,
                hintText: 'password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: .end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: .bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              MyButton(onTap: () {}, text: 'login'),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: widget.togglePages,
                    child: Text(
                      'Register now',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
