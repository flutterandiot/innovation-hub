// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectsHash() => r'd7104c0eed357fc82f8d05ed3188078eba3c5f9e';

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
String _$activeProjectHash() => r'590147519db377074c2516b026f68bfc27ff9fea';

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
