// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idea_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ideaIndexHash() => r'e4215a7cf4357324eed30f8e3d7b1d15a200a573';

/// See also [ideaIndex].
@ProviderFor(ideaIndex)
final ideaIndexProvider = AutoDisposeProvider<int>.internal(
  ideaIndex,
  name: r'ideaIndexProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ideaIndexHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IdeaIndexRef = AutoDisposeProviderRef<int>;
String _$ideaManageHash() => r'22963ff63b1fa6578ddedc735ab2657237bb179f';

/// See also [IdeaManage].
@ProviderFor(IdeaManage)
final ideaManageProvider = NotifierProvider<IdeaManage, Idea?>.internal(
  IdeaManage.new,
  name: r'ideaManageProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ideaManageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IdeaManage = Notifier<Idea?>;
String _$ideasHash() => r'dcf4267bb09e7338c25c31e0f04671dca8687491';

/// See also [Ideas].
@ProviderFor(Ideas)
final ideasProvider = NotifierProvider<Ideas, List<Idea>>.internal(
  Ideas.new,
  name: r'ideasProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ideasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Ideas = Notifier<List<Idea>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
