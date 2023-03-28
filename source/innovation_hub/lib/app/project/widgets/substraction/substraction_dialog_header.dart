// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:innovation_hub/app/model/component_model.dart';
import 'package:innovation_hub/app/model/project_model.dart';
import 'package:innovation_hub/constants.dart';

class DialogHeader extends ConsumerWidget {
  const DialogHeader({
    super.key,
    required this.component,
    required this.project,
  });
  final Component component;
  final Project project;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: const BoxDecoration(
          // color: Theme.of(context).disabledColor,
          ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                substractionIcon,
                fit: BoxFit.contain,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Substraction',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Idea hint
          Text.rich(
            TextSpan(
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontSize: 20,
                  ),
              text: 'Imagine the ', // default text style
              children: [
                TextSpan(
                  text: project.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                    decoration: TextDecoration.underline,
                    // decorationThickness: 2,
                    decorationColor: Colors.black26,
                    decorationStyle: TextDecorationStyle.wavy,
                  ),
                ),
                const TextSpan(
                  text: ' without the ',
                ),
                TextSpan(
                  text: component.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black26,
                    decorationStyle: TextDecorationStyle.wavy,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
