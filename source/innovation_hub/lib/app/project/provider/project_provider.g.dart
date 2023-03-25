// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectsHash() => r'f52989eb478ec256e8c54f4c4035580b71a60bb4';

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
String _$activeProjectHash() => r'90501e59ce8154698162aa65f436d308ea91b127';

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
String _$showSecondaryBodyHash() => r'2de912c1b34a45e1c76b5edb5ef790064ed1e87d';

/// A provider to manage show/hide secondbody  view
///
/// Copied from [ShowSecondaryBody].
@ProviderFor(ShowSecondaryBody)
final showSecondaryBodyProvider =
    NotifierProvider<ShowSecondaryBody, bool>.internal(
  ShowSecondaryBody.new,
  name: r'showSecondaryBodyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$showSecondaryBodyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ShowSecondaryBody = Notifier<bool>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
