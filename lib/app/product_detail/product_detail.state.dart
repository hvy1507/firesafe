
import 'package:firesafe_vnex/models/country/country.model.dart';
import 'package:firesafe_vnex/models/enum_values/load_state.dart';
import 'package:firesafe_vnex/models/product/product.model.dart';
import 'package:firesafe_vnex/models/supplier/supplier.short.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_detail.state.freezed.dart';
@freezed
class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState({
    @Default(LoadState.idle) LoadState loadState,
    @Default(null) ProductModel? product,
    @Default(null) String? countryName,
    @Default(null)SupplierShortModel? supplier,
    @Default('') String? error,
    @Default([]) List<String> combinedList,
  }) = _ProductDetailState;
}
