// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$componentIndexHash() => r'75334dddc08df52ed45c63510d4b45ba5d563378';

/// See also [componentIndex].
@ProviderFor(componentIndex)
final componentIndexProvider = AutoDisposeProvider<int>.internal(
  componentIndex,
  name: r'componentIndexProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$componentIndexHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ComponentIndexRef = AutoDisposeProviderRef<int>;
String _$componentControllerHash() =>
    r'1ca3c956a98df56e6f903571fa1199a5f8208845';

/// Keep alive to keep the component works on many screen
///
/// Copied from [ComponentController].
@ProviderFor(ComponentController)
final componentControllerProvider =
    NotifierProvider<ComponentController, Component?>.internal(
  ComponentController.new,
  name: r'componentControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$componentControllerHash,
  dependencies: <ProviderOrFamily>[activeProjectProvider],
  allTransitiveDependencies: <ProviderOrFamily>[activeProjectProvider],
);

typedef _$ComponentController = Notifier<Component?>;
String _$componentsHash() => r'e7362edb692dedc13d489bd89472ea2e5d87a185';

/// See also [Components].
@ProviderFor(Components)
final componentsProvider =
    NotifierProvider<Components, List<Component>>.internal(
  Components.new,
  name: r'componentsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$componentsHash,
  dependencies: <ProviderOrFamily>[activeProjectProvider],
  allTransitiveDependencies: <ProviderOrFamily>[activeProjectProvider],
);

typedef _$Components = Notifier<List<Component>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
