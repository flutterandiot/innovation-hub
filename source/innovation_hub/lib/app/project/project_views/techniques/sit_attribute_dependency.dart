import 'package:flutter/material.dart';

class SITAttributeDependency extends StatelessWidget {
  const SITAttributeDependency({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              'Attribute Dependency',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text('This technique is in developing'),
          ],
        ),
      ),
    );
  }
}
