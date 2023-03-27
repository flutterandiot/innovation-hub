// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innovation_hub/app_routing.dart';

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
    // final isLarge = Breakpoints.large.isActive(context);
    return SizedBox(
        width: width,
        height: height,
        child: TextButton(
          onPressed: () {
            _gotoStartupPage(context);
          },
          child: Image.asset(
            'assets/brand/logo-Innovation-HUB@3x.png',
            fit: BoxFit.contain,
          ),
        ));
  }

  void _gotoStartupPage(BuildContext context) {
    context.goNamed(AppRoute.home.name);
  }
}
