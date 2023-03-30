// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectsHash() => r'f7b93780295c44480f4ab773f501fa721e0eadaf';

/// See also [Projects].
@ProviderFor(Projects)
final projectsProvider =
    AutoDisposeNotifierProvider<Projects, List<Project>>.internal(
  Projects.new,
  name: r'projectsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$projectsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Projects = AutoDisposeNotifier<List<Project>>;
String _$activeProjectHash() => r'ec95a83dd3e66b6e90e47db61f4408d9e72129c0';

/// See also [ActiveProject].
@ProviderFor(ActiveProject)
final activeProjectProvider = NotifierProvider<ActiveProject, Project>.internal(
  ActiveProject.new,
  name: r'activeProjectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeProjectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ActiveProject = Notifier<Project>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
