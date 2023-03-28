import 'package:flutter/material.dart';

class SITDivision extends StatelessWidget {
  const SITDivision({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              'Division',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text('This technique is in developing'),
          ],
        ),
      ),
    );
  }
}
