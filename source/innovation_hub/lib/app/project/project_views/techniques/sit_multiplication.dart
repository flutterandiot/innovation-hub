import 'package:flutter/material.dart';

class SITMultiplication extends StatelessWidget {
  const SITMultiplication({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              'Multiplication',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text('This technique is in developing'),
          ],
        ),
      ),
    );
  }
}
