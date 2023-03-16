import 'package:flutter/material.dart';

class SITMethodPage extends StatelessWidget {
  const SITMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIT Method'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [Text('Select tool')],
        ),
      ),
    );
  }
}
