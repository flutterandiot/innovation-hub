// ignore_for_file: public_member_api_docs, sort_constructors_first
/*
 * Autogenerated header by File Header Comment extension - Donna Iwan
 * File:       home_page.dart
 * Created on: Mon Mar 13 2023
 * Author:     Tong Vu Than Dan
 *
 * Copyright (c) 2023 Tong Vu Than Dan
 *
 * Description: the home page of the app.
 * This page will use flutter_adaptive_scaffold with AdaptiveLayout to enable the adaptivity.
 *  topNavigation: show only on web
    primaryNavigation: on show on desktop (macOS, Windows, web) and Tablet/iPad
    secondaryNavigation: not use
    bottomNavigation: only show on Mobile, small screen
    body: show on all screen size
    secondaryBody: show on all screen sizes except small screen 
    bodyRatio: 0.3, ratio between body and secondary body
 */
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innovation_hub/app_routing.dart';

import '../project/provider/project_provider.dart';
import '../project/widgets/project_list_navi_rail.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
    required this.body,
  });

  final Widget body;
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    // final selectedIndex = ref.watch(destinationIndexProvider);
    final isLight = Theme.of(context).brightness == Brightness.light;
    final theme = Theme.of(context);
    final iconColor = isLight ? theme.primaryColor : theme.primaryColorDark;

    final List<NavigationDestination> destinations = [
      NavigationDestination(
        icon: Icon(Icons.dashboard_outlined, color: iconColor),
        selectedIcon: const Icon(Icons.dashboard),
        label: 'Projects',
      ),
      NavigationDestination(
        icon: Icon(Icons.explore_outlined, color: iconColor),
        selectedIcon: const Icon(Icons.explore),
        label: 'Explore',
      ),
      NavigationDestination(
        icon: Icon(
          Icons.settings_outlined,
          color: iconColor,
        ),
        selectedIcon: const Icon(Icons.settings),
        label: 'Settings',
      ),
    ];

    void _selectedNavi(BuildContext context, int index) {
      if (index == 0) {
        context.goNamed(AppRoute.projects.name);
      } else if (index == 1) {
        context.goNamed(AppRoute.explore.name);
      } else if (index == 2) {
        context.goNamed(AppRoute.settings.name);
      }
    }

    final projectList = ref.watch(projectsProvider);
    return Scaffold(
      body: AdaptiveLayout(
        bodyRatio: 0.6,
        primaryNavigation: SlotLayout(
          config: {
            Breakpoints.medium: SlotLayout.from(
              key: const Key('primary-navi-medium'),
              // inAnimation: AdaptiveScaffold.fadeIn,
              // outAnimation: AdaptiveScaffold.fadeOut,
              builder: (context) => AdaptiveScaffold.standardNavigationRail(
                destinations: destinations.map(AdaptiveScaffold.toRailDestination).toList(),
                leading: Image.asset(
                  'assets/brand/logo-ihub@3x.png',
                  height: 48,
                ),
                onDestinationSelected: (index) {
                  // ref.read(destinationIndexProvider.notifier).state = index;
                  // debugPrint('New index: $selectedIndex');
                  _selectedNavi(context, index);
                },
                // trailing: projectList.isEmpty
                //     ? null
                //     : ListView.builder(
                //         itemCount: projectList.length,
                //         itemBuilder: (context, index) {
                //           return ListTile(
                //             leading: Text('${index + 1}. '),
                //             title: Text(projectList[index].name),
                //           );
                //         },
                //       ),
              ),
            ),
            Breakpoints.large: SlotLayout.from(
              key: const Key('primary-navi-large'),
              inAnimation: AdaptiveScaffold.fadeIn,
              outAnimation: AdaptiveScaffold.leftInOut,
              builder: (context) => AdaptiveScaffold.standardNavigationRail(
                extended: true,
                destinations: destinations.map(AdaptiveScaffold.toRailDestination).toList(),
                leading: Image.asset(
                  'assets/brand/logo-Innovation-HUB@3x.png',
                  height: 64,
                ),
                onDestinationSelected: (index) {
                  // ref.read(destinationIndexProvider.notifier).state = index;
                  // debugPrint('New index: $selectedIndex');
                  _selectedNavi(context, index);
                },
                trailing: projectList.isEmpty
                    ? null
                    : SizedBox(
                        height: 300,
                        child: ProjectListNaviRail(projectList: projectList),
                      ),
              ),
            ),
          },
        ), // !primaryNavi
        body: SlotLayout(
          config: {
            Breakpoints.smallAndUp: SlotLayout.from(
              key: const Key('Small Body'),
              builder: (_) {
                return widget.body;
              },
            ),
            // Breakpoints.medium: SlotLayout.from(
            //   key: const Key('medium-body'),
            //   builder: (_) {
            //     return widget.body;
            //   },
            // ),
            // Breakpoints.large: SlotLayout.from(
            //   key: const Key('large-body'),
            //   builder: (_) {
            //     return widget.body;
            //   },
            // ),
          },
        ),
        // secondaryBody: (showSecondaryBody)
        //     ? SlotLayout(
        //         config: {
        //           Breakpoints.smallAndUp: SlotLayout.from(
        //             key: const Key('second-body-small-n-up'),
        //             builder: (context) {
        //               return const Placeholder(
        //                 child: Center(
        //                   child: Text('Second body'),
        //                 ),
        //               );
        //             },
        //           ),
        //         },
        //       )
        //     : null,
        bottomNavigation: SlotLayout(
          config: {
            Breakpoints.small: SlotLayout.from(
              key: const Key('small-bottom-navi'),
              builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
                destinations: destinations,
                onDestinationSelected: (index) {
                  _selectedNavi(context, index);
                  // ref.read(destinationIndexProvider.notifier).state = value;
                  // debugPrint('New index: $selectedIndex');
                },
              ),
            ),
          },
        ),
      ),
    );
  }
}
