import 'package:flutter/material.dart';

class AppleSignInButton extends StatelessWidget {
  final void Function() onTap;
  const AppleSignInButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const .all(25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: .circular(25),
          border: .all(color: Theme.of(context).colorScheme.tertiary),
        ),
        child: Image.asset(
          'lib/assets/images/apple-logo.png',
          height: 22,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
