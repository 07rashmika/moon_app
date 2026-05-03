import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_app/features/auth/presentation/components/my_button.dart';
import 'package:moon_app/features/auth/presentation/components/my_textfield.dart';
import 'package:moon_app/features/auth/presentation/cubits/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  final void Function() togglePages;
  const RegisterScreen({super.key, required this.togglePages});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  void register() {
    //prepare info
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    //auth cubit
    final authCubit = context.read<AuthCubit>();

    //ensure fields are not empty
    if (email.isNotEmpty &&
        name.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      //ensure passwords match
      if (password == confirmPassword) {
        authCubit.register(name, email, password);
      }
      //passwords do not match
      else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      }
    }
    //fields are empty
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all areas!')),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  "Let's create an account for you",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),

                const SizedBox(height: 25),

                MyTextfield(
                  controller: nameController,
                  hintText: 'name',
                  obscureText: false,
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

                const SizedBox(height: 25),

                MyTextfield(
                  controller: confirmPasswordController,
                  hintText: 'confirm password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                const SizedBox(height: 25),

                MyButton(onTap: register, text: 'sign up'),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        'Login',
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
      ),
    );
  }
}
