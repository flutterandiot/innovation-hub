import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProjectWorkspace extends ConsumerStatefulWidget {
  const ProjectWorkspace({super.key});

  @override
  ConsumerState<ProjectWorkspace> createState() => _ProjectWorkspaceState();
}

class _ProjectWorkspaceState extends ConsumerState<ProjectWorkspace> {
  late final List<NavigationDestination> destinations;
  @override
  void initState() {
    super.initState();

    _initDestinations(context);
  }

  void _initDestinations(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final theme = Theme.of(context);
    final iconColor = isLight ? theme.primaryColor : theme.primaryColorDark;

    destinations = [
      NavigationDestination(
        icon: Icon(Icons.dashboard_outlined, color: iconColor),
        selectedIcon: const Icon(Icons.dashboard),
        label: 'Dashboard',
      ),
      NavigationDestination(
        icon: Icon(Icons.category, color: iconColor),
        selectedIcon: const Icon(Icons.category_rounded),
        label: 'Compoments',
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
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
