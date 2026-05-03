import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({super.key, required this.title, required this.action});

  final String title;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: .circular(12),
      ),

      //padding inside
      padding: const .all(25),

      //padding outside
      margin: const .only(left: 25, right: 25, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: .bold, fontSize: 18)),
          action,
        ],
      ),
    );
  }
}
