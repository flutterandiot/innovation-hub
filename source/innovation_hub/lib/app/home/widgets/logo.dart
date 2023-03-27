// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final isLarge = Breakpoints.large.isActive(context);
    return SizedBox(
      width: width,
      height: height,
      child: isLarge
          ? Image.asset(
              'assets/brand/logo-Innovation-HUB@3x.png',
              fit: BoxFit.contain,
            )
          : Image.asset(
              'assets/brand/logo-ihub@3x.png',
              fit: BoxFit.contain,
            ),
    );
  }
}
