// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchWordHash() => r'ae3d168dc83b2784a46156f75a8595ebbfe28753';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SearchWord
    extends BuildlessAutoDisposeAsyncNotifier<WordResult?> {
  late final String query;

  FutureOr<WordResult?> build(
    String query,
  );
}

/// See also [SearchWord].
@ProviderFor(SearchWord)
const searchWordProvider = SearchWordFamily();

/// See also [SearchWord].
class SearchWordFamily extends Family<AsyncValue<WordResult?>> {
  /// See also [SearchWord].
  const SearchWordFamily();

  /// See also [SearchWord].
  SearchWordProvider call(
    String query,
  ) {
    return SearchWordProvider(
      query,
    );
  }

  @override
  SearchWordProvider getProviderOverride(
    covariant SearchWordProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchWordProvider';
}

/// See also [SearchWord].
class SearchWordProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SearchWord, WordResult?> {
  /// See also [SearchWord].
  SearchWordProvider(
    String query,
  ) : this._internal(
          () => SearchWord()..query = query,
          from: searchWordProvider,
          name: r'searchWordProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchWordHash,
          dependencies: SearchWordFamily._dependencies,
          allTransitiveDependencies:
              SearchWordFamily._allTransitiveDependencies,
          query: query,
        );

  SearchWordProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  FutureOr<WordResult?> runNotifierBuild(
    covariant SearchWord notifier,
  ) {
    return notifier.build(
      query,
    );
  }

  @override
  Override overrideWith(SearchWord Function() create) {
    return ProviderOverride(
      origin: this,
      override: SearchWordProvider._internal(
        () => create()..query = query,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SearchWord, WordResult?>
      createElement() {
    return _SearchWordProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchWordProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchWordRef on AutoDisposeAsyncNotifierProviderRef<WordResult?> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchWordProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SearchWord, WordResult?>
    with SearchWordRef {
  _SearchWordProviderElement(super.provider);

  @override
  String get query => (origin as SearchWordProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
