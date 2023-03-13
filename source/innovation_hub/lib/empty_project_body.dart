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

class EmptyProjectPageBody extends StatelessWidget {
  const EmptyProjectPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 32, right: 16, top: 48),
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
              'Hello innovator,',
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
                Image.asset('assets/images/time-to-innovate.png'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(
                  width: 20,
                ),
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
          ],
        ),
      ),
    );
  }
}
