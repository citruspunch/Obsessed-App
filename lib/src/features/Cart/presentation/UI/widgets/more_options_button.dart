import 'package:flutter/material.dart';

class MoreOptionsButton extends StatelessWidget {
  const MoreOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showAboutDialog(
          context: context,
          applicationName: 'Obsessed',
          applicationVersion: '1.0.0',
          applicationLegalese: '© 2021 Obsessed. All rights reserved.',
        );
      },
      child: const Icon(
        Icons.more_horiz,
        size: 37,
      ),
    );
  }
}