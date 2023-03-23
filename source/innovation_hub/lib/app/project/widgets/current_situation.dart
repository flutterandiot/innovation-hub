import 'package:flutter/material.dart';

class CurrentSituation extends StatelessWidget {
  const CurrentSituation({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.2,
        ),
        child: Column(
          children: const [
            TextField(
              decoration: InputDecoration(
                labelText: 'Current situation of a product or service',
              ),
            ),
          ],
        ),
      );
    });
  }
}
