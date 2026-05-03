import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_app/components/drawer_tile.dart';
import 'package:moon_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:moon_app/features/profile/profile_screen.dart';
import 'package:moon_app/features/settings/presentation/settings_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    authCubit.logout();
  }

  void confirmLogout(BuildContext context) {
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout?'),
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
              logout(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(child: Icon(Icons.favorite)),

                //home
                DrawerTile(
                  text: 'Home',
                  icon: Icons.home,
                  onTap: () => Navigator.of(context).pop(),
                ),

                //profile
                DrawerTile(
                  text: 'Profile',
                  icon: Icons.person,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                ),

                //settings
                DrawerTile(
                  text: 'Settings',
                  icon: Icons.settings,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                ),
              ],
            ),
            DrawerTile(
              text: 'Logout',
              icon: Icons.logout,
              onTap: () {
                confirmLogout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
