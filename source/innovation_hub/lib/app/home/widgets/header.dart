import 'package:flutter/material.dart';
import 'package:innovation_hub/app/home/widgets/logo.dart';

class StartupPageHeader extends StatelessWidget {
  const StartupPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: AppBar().preferredSize.height * 0.8,
          child: const BrandLogo(),
        ),
        const CircleAvatar(
          child: Icon(Icons.person),
        ),
      ],
    );
  }
}
