import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:moon_app/features/settings/presentation/settings_tile.dart';

//Apple requires that users can delete their account to be approved

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //confirm account deletion
  void confirmAccountDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account?'),
        actions: [
          // cancel button
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),

          // yes button
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              handleAccountDelete();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  //handle account deletion
  void handleAccountDelete() async {
    try {
      //loading...
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      //delete account
      final authCubit = context.read<AuthCubit>();
      await authCubit.deleteAccount();

      //done loading -> after deletion -> navigates to auth page
      if (mounted) {
        Navigator.pop(context); //removes loading circle
        Navigator.pop(context); //removes settings page
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: [
          //delete account
          SettingsTile(
            title: 'Delete Account',
            action: IconButton(
              onPressed: confirmAccountDelete,
              icon: const Icon(Icons.delete_forever),
            ),
          ),
        ],
      ),
    );
  }
}
