// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProductDetailState {
  LoadState get loadState => throw _privateConstructorUsedError;
  ProductModel? get product => throw _privateConstructorUsedError;
  String? get countryName => throw _privateConstructorUsedError;
  SupplierShortModel? get supplier => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  List<String> get combinedList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProductDetailStateCopyWith<ProductDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDetailStateCopyWith<$Res> {
  factory $ProductDetailStateCopyWith(
          ProductDetailState value, $Res Function(ProductDetailState) then) =
      _$ProductDetailStateCopyWithImpl<$Res, ProductDetailState>;
  @useResult
  $Res call(
      {LoadState loadState,
      ProductModel? product,
      String? countryName,
      SupplierShortModel? supplier,
      String? error,
      List<String> combinedList});
}

/// @nodoc
class _$ProductDetailStateCopyWithImpl<$Res, $Val extends ProductDetailState>
    implements $ProductDetailStateCopyWith<$Res> {
  _$ProductDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadState = null,
    Object? product = freezed,
    Object? countryName = freezed,
    Object? supplier = freezed,
    Object? error = freezed,
    Object? combinedList = null,
  }) {
    return _then(_value.copyWith(
      loadState: null == loadState
          ? _value.loadState
          : loadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      countryName: freezed == countryName
          ? _value.countryName
          : countryName // ignore: cast_nullable_to_non_nullable
              as String?,
      supplier: freezed == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as SupplierShortModel?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      combinedList: null == combinedList
          ? _value.combinedList
          : combinedList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductDetailStateImplCopyWith<$Res>
    implements $ProductDetailStateCopyWith<$Res> {
  factory _$$ProductDetailStateImplCopyWith(_$ProductDetailStateImpl value,
          $Res Function(_$ProductDetailStateImpl) then) =
      __$$ProductDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadState loadState,
      ProductModel? product,
      String? countryName,
      SupplierShortModel? supplier,
      String? error,
      List<String> combinedList});
}

/// @nodoc
class __$$ProductDetailStateImplCopyWithImpl<$Res>
    extends _$ProductDetailStateCopyWithImpl<$Res, _$ProductDetailStateImpl>
    implements _$$ProductDetailStateImplCopyWith<$Res> {
  __$$ProductDetailStateImplCopyWithImpl(_$ProductDetailStateImpl _value,
      $Res Function(_$ProductDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadState = null,
    Object? product = freezed,
    Object? countryName = freezed,
    Object? supplier = freezed,
    Object? error = freezed,
    Object? combinedList = null,
  }) {
    return _then(_$ProductDetailStateImpl(
      loadState: null == loadState
          ? _value.loadState
          : loadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      countryName: freezed == countryName
          ? _value.countryName
          : countryName // ignore: cast_nullable_to_non_nullable
              as String?,
      supplier: freezed == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as SupplierShortModel?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      combinedList: null == combinedList
          ? _value._combinedList
          : combinedList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$ProductDetailStateImpl implements _ProductDetailState {
  const _$ProductDetailStateImpl(
      {this.loadState = LoadState.idle,
      this.product = null,
      this.countryName = null,
      this.supplier = null,
      this.error = '',
      final List<String> combinedList = const []})
      : _combinedList = combinedList;

  @override
  @JsonKey()
  final LoadState loadState;
  @override
  @JsonKey()
  final ProductModel? product;
  @override
  @JsonKey()
  final String? countryName;
  @override
  @JsonKey()
  final SupplierShortModel? supplier;
  @override
  @JsonKey()
  final String? error;
  final List<String> _combinedList;
  @override
  @JsonKey()
  List<String> get combinedList {
    if (_combinedList is EqualUnmodifiableListView) return _combinedList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_combinedList);
  }

  @override
  String toString() {
    return 'ProductDetailState(loadState: $loadState, product: $product, countryName: $countryName, supplier: $supplier, error: $error, combinedList: $combinedList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductDetailStateImpl &&
            (identical(other.loadState, loadState) ||
                other.loadState == loadState) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.countryName, countryName) ||
                other.countryName == countryName) &&
            (identical(other.supplier, supplier) ||
                other.supplier == supplier) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality()
                .equals(other._combinedList, _combinedList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loadState, product, countryName,
      supplier, error, const DeepCollectionEquality().hash(_combinedList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductDetailStateImplCopyWith<_$ProductDetailStateImpl> get copyWith =>
      __$$ProductDetailStateImplCopyWithImpl<_$ProductDetailStateImpl>(
          this, _$identity);
}

abstract class _ProductDetailState implements ProductDetailState {
  const factory _ProductDetailState(
      {final LoadState loadState,
      final ProductModel? product,
      final String? countryName,
      final SupplierShortModel? supplier,
      final String? error,
      final List<String> combinedList}) = _$ProductDetailStateImpl;

  @override
  LoadState get loadState;
  @override
  ProductModel? get product;
  @override
  String? get countryName;
  @override
  SupplierShortModel? get supplier;
  @override
  String? get error;
  @override
  List<String> get combinedList;
  @override
  @JsonKey(ignore: true)
  _$$ProductDetailStateImplCopyWith<_$ProductDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
