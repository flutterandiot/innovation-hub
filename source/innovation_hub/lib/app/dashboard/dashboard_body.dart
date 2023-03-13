/*
* Autogenerated header by File Header Comment extension - Donna Iwan
* File:       empty_project_body.dart
* Created on: Mon Mar 13 2023
* Author:     Tong Vu Than Dan
*
* Copyright (c) 2023 ${Dantopia}
* Website:     dantopia.vn
*
* Description: This file is shown when there is not any project in database
 */
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:innovation_hub/utils/padding.dart';
import 'package:innovation_hub/utils/space.dart';

class DashboardPageBody extends StatelessWidget {
  const DashboardPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = Breakpoints.small.isActive(context);
    return Container(
      padding: const EdgeInsets.only(left: 4 * defaultPadding, right: 2 * defaultPadding, top: 4 * defaultPadding),
      color: Colors.grey[200],
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 48,
            ),
            Text(
              'Welcome to our dashboard,',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'time to innovate!',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: isSmallScreen ? 300 : 450,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/time-to-innovate.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            Space.y(20),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 24,
                spacing: 32,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      //TODO - add action code
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('New idea project'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(128, 64),
                    ),
                  ),
                  // Space.x(20),
                  ElevatedButton.icon(
                    onPressed: () {
                      //TODO - add action code
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('New problem solving project'),
                    style: ElevatedButton.styleFrom(minimumSize: const Size(128, 64), backgroundColor: Colors.amber),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
