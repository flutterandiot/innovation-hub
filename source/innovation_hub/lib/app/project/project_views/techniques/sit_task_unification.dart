import 'package:flutter/material.dart';

class SITTaskUnification extends StatelessWidget {
  const SITTaskUnification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              'Task Unification',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text('This technique is in developing'),
          ],
        ),
      ),
    );
  }
}
