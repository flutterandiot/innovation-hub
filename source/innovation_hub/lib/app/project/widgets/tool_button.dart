// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SitToolButton extends StatelessWidget {
  const SitToolButton({
    Key? key,
    required this.backgroundColor,
    required this.title,
    this.icon,
    required this.onTap,
    this.width = 200,
    this.height = 60,
  }) : super(key: key);
  final Color backgroundColor;
  final String title;
  final Widget? icon;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        tileColor: backgroundColor,
        onTap: onTap,
        leading: icon ?? icon!,
        title: Text(title),
      ),
    );
  }
}
