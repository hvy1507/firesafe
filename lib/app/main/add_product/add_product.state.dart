import 'dart:io';

import 'package:firesafe_vnex/components/commons/product_categories.dart';
import 'package:firesafe_vnex/models/country/country.model.dart';
import 'package:firesafe_vnex/models/enum_values/load_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_product.state.freezed.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState({
    @Default(LoadState.idle) LoadState loadState,
    @Default(null) String? newProductId,
    @Default('') String name,
    @Default('') String originId,
    @Default('') String brand,
    @Default('') String model,
    @Default('') String shortDescription,
    @Default(true) bool available,
    @Default(0) int warranty,
    @Default('') String packaging,
    @Default(0) int shippingTime,
    @Default('') String hasSample,
    @Default('') String productionRate,
    @Default(null) String? accessories,
    @Default(null) String? postSupport,
    @Default(null) String? faq,
    @Default(null) String? shape,
    @Default(null) String? color,
    @Default(null) String? material,
    @Default(null) int? weight,
    @Default(null) int? volume,
    @Default(null) String? structure,
    @Default(null) String? fireResistant,
    @Default(null) String? waterResistant,
    @Default(null) String? application,
    @Default(null) Map<String, String>? additionalSpecification,
    @Default(null) int? maxPrice,
    @Default(null) int? minPrice,
    @Default(null) int? price,
    @Default([]) List<Category> categories,
    @Default(null) File? thumbnail,
    @Default(null) List<File>? images,
    @Default([]) List<(String, File)> certificates,
    @Default([]) List<CountryModel> countries,
    @Default(null) String? error,
  }) = _AddProductState;
}
