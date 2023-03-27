import 'package:flutter/material.dart';

class SITSubstraction extends StatelessWidget {
  const SITSubstraction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              'Substraction',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text('This technique is in developing'),
          ],
        ),
      ),
    );
  }
}
