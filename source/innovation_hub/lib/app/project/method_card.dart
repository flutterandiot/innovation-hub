// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MethodCard extends HookWidget {
  const MethodCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.useCase,
    required this.backgroundColor,
    required this.onTap,
    this.width,
    this.height,
    this.tooltip,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String useCase;
  final Color backgroundColor;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final String? tooltip;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isShowTooltip = useState<bool>(false);
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: Tooltip(
        message: isShowTooltip.value ? tooltip : 'Select eye icon to show/hide short explaination',
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: width ?? 300.0,
              height: height ?? 100,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      title,
                      style: textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                    //Use spacer for leading to center the title
                    // leading: const Spacer(),

                    trailing: IconButton(
                      onPressed: () {
                        isShowTooltip.value = !isShowTooltip.value;
                      },
                      icon: isShowTooltip.value ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    useCase,
                    style: textTheme.bodySmall!.copyWith(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
