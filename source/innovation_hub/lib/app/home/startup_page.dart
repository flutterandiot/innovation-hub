/*
* Autogenerated header by File Header Comment extension - Donna Iwan
* File:       startup_page.dart
* Created on: Sat Mar 25 2023
* Author:     Tong Vu Than Dan
*
* Copyright (c) 2023 Tong Vu Than Dan
* Website:     dantopia.vn
*
* Description: This page is show when the app launch.
 */
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:innovation_hub/utils/app_utils.dart';

import '../project/widgets/new_project_dialog.dart';
import '../project/widgets/project_container.dart';
import 'widgets/header.dart';

class StartUpPage extends HookWidget {
  const StartUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<int, String> greeting = AppUtilities.getGreetingMessage();
    final screenSize = MediaQuery.of(context).size;
    final tabController = useTabController(initialLength: 2);
    final showGrid = useState(true);

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: const StartupPageHeader(),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: screenSize.width * 0.15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      greeting.values.first,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await _showNewProjectDialog(context);
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.indigo,
                      size: 48,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        controller: tabController,
                        tabs: const [
                          Tab(
                            // icon: Icon(Icons.history),
                            text: 'Recent activities',
                          ),
                          Tab(
                            // icon: Icon(Icons.favorite),
                            text: 'Favorites',
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        showGrid.value = false;
                      },
                      icon: Icon(
                        Icons.list,
                        color: !showGrid.value ? Colors.amber : Theme.of(context).unselectedWidgetColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showGrid.value = true;
                      },
                      icon: Icon(
                        Icons.grid_view_rounded,
                        color: showGrid.value ? Colors.amber : Theme.of(context).unselectedWidgetColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.8,
                width: screenSize.width * 0.75,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ProjectsContainer(
                      gridView: showGrid.value,
                      isFavarite: false,
                    ),
                    ProjectsContainer(
                      gridView: showGrid.value,
                      isFavarite: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showNewProjectDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const NewProjectDialog(),
        );
      },
    );
  }
}
