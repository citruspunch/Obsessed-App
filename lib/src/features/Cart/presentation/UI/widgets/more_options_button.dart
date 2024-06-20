import 'package:flutter/material.dart';

class MoreOptionsButton extends StatelessWidget {
  const MoreOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(
        Icons.more_horiz,
        size: 37,
      ),
    );
  }
}