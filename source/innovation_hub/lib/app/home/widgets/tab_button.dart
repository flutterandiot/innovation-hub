import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  const TabButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Colors.amber,
          ),
        ),
      ),
      child: const Text('Tab Button'),
    );
  }
}
