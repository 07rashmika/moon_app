import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final void Function() onTap;

  const GoogleSignInButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const .all(25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Theme.of(context).colorScheme.tertiary),
        ),
        child: Image.asset('lib/assets/images/google.png', height: 22),
      ),
    );
  }
}
