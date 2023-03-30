// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idea_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ideaControlHash() => r'0057c90827fbe3c317e3d920e39b4fd9818d90fb';

/// See also [IdeaControl].
@ProviderFor(IdeaControl)
final ideaControlProvider = NotifierProvider<IdeaControl, Idea?>.internal(
  IdeaControl.new,
  name: r'ideaControlProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ideaControlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IdeaControl = Notifier<Idea?>;
String _$ideasHash() => r'33d59a02510b922a4938be355602bd52e0bbfcb2';

/// See also [Ideas].
@ProviderFor(Ideas)
final ideasProvider = AutoDisposeNotifierProvider<Ideas, List<Idea>>.internal(
  Ideas.new,
  name: r'ideasProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ideasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Ideas = AutoDisposeNotifier<List<Idea>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
