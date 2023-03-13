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
import 'package:innovation_hub/app/dashboard/dashboard_body.dart';
import 'package:innovation_hub/app/explore/explore_body.dart';
import 'package:innovation_hub/app/home/home_page_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(destinationIndexProvider);
    final isLight = Theme.of(context).brightness == Brightness.light;
    final theme = Theme.of(context);
    final iconColor = isLight ? theme.primaryColor : theme.primaryColorDark;

    final List<NavigationDestination> destinations = [
      NavigationDestination(
        icon: Icon(Icons.dashboard_outlined, color: iconColor),
        selectedIcon: const Icon(Icons.dashboard),
        label: 'Dashboard',
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

    return Scaffold(
      body: AdaptiveLayout(
        primaryNavigation: SlotLayout(
          config: {
            Breakpoints.medium: SlotLayout.from(
              key: const Key('primary-navi-medium'),
              inAnimation: AdaptiveScaffold.fadeIn,
              outAnimation: AdaptiveScaffold.fadeOut,
              builder: (context) => AdaptiveScaffold.standardNavigationRail(
                destinations: destinations.map(AdaptiveScaffold.toRailDestination).toList(),
                leading: Image.asset(
                  'assets/brand/logo-ihub@3x.png',
                  height: 48,
                ),
                onDestinationSelected: (index) {
                  ref.read(destinationIndexProvider.notifier).state = index;
                  debugPrint('New index: $selectedIndex');
                },
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
                  ref.read(destinationIndexProvider.notifier).state = index;
                  debugPrint('New index: $selectedIndex');
                },
              ),
            ),
          },
        ), // !primaryNavi
        body: SlotLayout(
          config: {
            Breakpoints.small: SlotLayout.from(
              key: const Key('Small Body'),
              builder: (_) {
                switch (selectedIndex) {
                  case 0:
                    return const DashboardPageBody();
                  case 1:
                    return const ExplorePageBody();
                  default:
                    return const DashboardPageBody();
                }
              },
            ),
            Breakpoints.medium: SlotLayout.from(
              key: const Key('medium-body'),
              builder: (_) {
                switch (selectedIndex) {
                  case 0:
                    return const DashboardPageBody();
                  case 1:
                    return const ExplorePageBody();
                  default:
                    return const DashboardPageBody();
                }
              },
            ),
            Breakpoints.large: SlotLayout.from(
              key: const Key('large-body'),
              builder: (_) {
                switch (selectedIndex) {
                  case 0:
                    return const DashboardPageBody();
                  case 1:
                    return const ExplorePageBody();
                  default:
                    return const DashboardPageBody();
                }
              },
            ),
          },
        ),
        bottomNavigation: SlotLayout(
          config: {
            Breakpoints.small: SlotLayout.from(
              key: const Key('small-bottom-navi'),
              builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
                destinations: destinations,
                onDestinationSelected: (value) {
                  ref.read(destinationIndexProvider.notifier).state = value;
                  debugPrint('New index: $selectedIndex');
                },
              ),
            ),
          },
        ),
      ),
    );
  }
}
