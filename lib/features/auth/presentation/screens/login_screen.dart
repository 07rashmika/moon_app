import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_app/features/auth/presentation/components/apple_sign_in_button.dart';
import 'package:moon_app/features/auth/presentation/components/google_sign_in_button.dart';
import 'package:moon_app/features/auth/presentation/components/my_button.dart';
import 'package:moon_app/features/auth/presentation/components/my_textfield.dart';
import 'package:moon_app/features/auth/presentation/cubits/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? togglePages;

  const LoginScreen({super.key, required this.togglePages});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late final authCubit = context.read<AuthCubit>();

  void login() {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.login(email, password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please check the username and password again',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: .bold,
            ),
          ),
        ),
      );
    }
  }

  void openForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Forgot Password?'),
        content: MyTextfield(
          controller: emailController,
          hintText: 'Enter email',
          obscureText: false,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),

          TextButton(
            onPressed: () async {
              String message = await authCubit.forgotPassword(
                emailController.text,
              );

              if (message ==
                  'Password reset email has sent! Please check your inbox') {
                Navigator.pop(context);
                emailController.clear();
              }

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
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
                      GestureDetector(
                        onTap: openForgotPasswordDialog,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  MyButton(onTap: login, text: 'login'),

                  const SizedBox(height: 25),

                  //other sign in options area
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Padding(
                        padding: const .symmetric(horizontal: 25.0),
                        child: const Text('Or sign in with'),
                      ),
                      Expanded(
                        child: Divider(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      AppleSignInButton(onTap: () {}),
                      const SizedBox(width: 20),
                      GoogleSignInButton(onTap: () {}),
                    ],
                  ),

                  const SizedBox(height: 25),

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

                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
