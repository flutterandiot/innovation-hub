// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$componentControllerHash() =>
    r'adc2ba25f93a44e21b63f9e95c2322b552547007';

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
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ComponentController = Notifier<Component?>;
String _$componentsHash() => r'621fa1d17901682146682b275346cf2378a42135';

/// See also [Components].
@ProviderFor(Components)
final componentsProvider =
    NotifierProvider<Components, List<Component>>.internal(
  Components.new,
  name: r'componentsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$componentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Components = Notifier<List<Component>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
