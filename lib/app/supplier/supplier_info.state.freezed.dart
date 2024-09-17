// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supplier_info.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SupplierInfoState {
  LoadState get loadState => throw _privateConstructorUsedError;
  List<ProductShortModel> get products => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  SupplierModel? get info => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SupplierInfoStateCopyWith<SupplierInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplierInfoStateCopyWith<$Res> {
  factory $SupplierInfoStateCopyWith(
          SupplierInfoState value, $Res Function(SupplierInfoState) then) =
      _$SupplierInfoStateCopyWithImpl<$Res, SupplierInfoState>;
  @useResult
  $Res call(
      {LoadState loadState,
      List<ProductShortModel> products,
      int currentPage,
      SupplierModel? info,
      String? error});
}

/// @nodoc
class _$SupplierInfoStateCopyWithImpl<$Res, $Val extends SupplierInfoState>
    implements $SupplierInfoStateCopyWith<$Res> {
  _$SupplierInfoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadState = null,
    Object? products = null,
    Object? currentPage = null,
    Object? info = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      loadState: null == loadState
          ? _value.loadState
          : loadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductShortModel>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      info: freezed == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as SupplierModel?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SupplierInfoStateImplCopyWith<$Res>
    implements $SupplierInfoStateCopyWith<$Res> {
  factory _$$SupplierInfoStateImplCopyWith(_$SupplierInfoStateImpl value,
          $Res Function(_$SupplierInfoStateImpl) then) =
      __$$SupplierInfoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadState loadState,
      List<ProductShortModel> products,
      int currentPage,
      SupplierModel? info,
      String? error});
}

/// @nodoc
class __$$SupplierInfoStateImplCopyWithImpl<$Res>
    extends _$SupplierInfoStateCopyWithImpl<$Res, _$SupplierInfoStateImpl>
    implements _$$SupplierInfoStateImplCopyWith<$Res> {
  __$$SupplierInfoStateImplCopyWithImpl(_$SupplierInfoStateImpl _value,
      $Res Function(_$SupplierInfoStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadState = null,
    Object? products = null,
    Object? currentPage = null,
    Object? info = freezed,
    Object? error = freezed,
  }) {
    return _then(_$SupplierInfoStateImpl(
      loadState: null == loadState
          ? _value.loadState
          : loadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductShortModel>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      info: freezed == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as SupplierModel?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SupplierInfoStateImpl implements _SupplierInfoState {
  const _$SupplierInfoStateImpl(
      {this.loadState = LoadState.idle,
      final List<ProductShortModel> products = const [],
      this.currentPage = 1,
      this.info = null,
      this.error = ''})
      : _products = products;

  @override
  @JsonKey()
  final LoadState loadState;
  final List<ProductShortModel> _products;
  @override
  @JsonKey()
  List<ProductShortModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final SupplierModel? info;
  @override
  @JsonKey()
  final String? error;

  @override
  String toString() {
    return 'SupplierInfoState(loadState: $loadState, products: $products, currentPage: $currentPage, info: $info, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupplierInfoStateImpl &&
            (identical(other.loadState, loadState) ||
                other.loadState == loadState) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loadState,
      const DeepCollectionEquality().hash(_products), currentPage, info, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SupplierInfoStateImplCopyWith<_$SupplierInfoStateImpl> get copyWith =>
      __$$SupplierInfoStateImplCopyWithImpl<_$SupplierInfoStateImpl>(
          this, _$identity);
}

abstract class _SupplierInfoState implements SupplierInfoState {
  const factory _SupplierInfoState(
      {final LoadState loadState,
      final List<ProductShortModel> products,
      final int currentPage,
      final SupplierModel? info,
      final String? error}) = _$SupplierInfoStateImpl;

  @override
  LoadState get loadState;
  @override
  List<ProductShortModel> get products;
  @override
  int get currentPage;
  @override
  SupplierModel? get info;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$SupplierInfoStateImplCopyWith<_$SupplierInfoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
