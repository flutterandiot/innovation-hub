import 'package:flutter/material.dart';
import 'package:innovation_hub/utils/space.dart';

class ListComponents extends StatelessWidget {
  const ListComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.2,
        ),
        child: Column(
          children: [
            const TextField(
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'List all internal components',
              ),
            ),
            const Text(
              'Make a list of the internal components (generally, the things attached or directly part of the product, process, or service)',
            ),
            Space.y(32),
            const TextField(
              decoration: InputDecoration(
                labelText: 'List all external components',
              ),
            ),
            const Text(
              'external components (those in the immediate vicinity - within the closed world)',
              textAlign: TextAlign.start,
            ),
          ],
        ),
      );
    });
  }
}
