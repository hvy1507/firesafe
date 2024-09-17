
import 'package:firesafe_vnex/models/country/country.model.dart';
import 'package:firesafe_vnex/models/enum_values/load_state.dart';
import 'package:firesafe_vnex/models/product/product.model.dart';
import 'package:firesafe_vnex/models/product/product.short.model.dart';
import 'package:firesafe_vnex/models/supplier/supplier.model.dart';
import 'package:firesafe_vnex/models/supplier/supplier.short.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier_info.state.freezed.dart';
@freezed
class SupplierInfoState with _$SupplierInfoState {
  const factory SupplierInfoState({
    @Default(LoadState.idle) LoadState loadState,
    @Default([]) List<ProductShortModel> products,
    @Default(1) int currentPage,
    @Default(null) SupplierModel? info,
    @Default('') String? error,
  }) = _SupplierInfoState;
}
