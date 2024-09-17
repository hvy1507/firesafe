// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products_category.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductByCategoryResponse _$GetProductByCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    GetProductByCategoryResponse(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductShortModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetProductByCategoryResponseToJson(
        GetProductByCategoryResponse instance) =>
    <String, dynamic>{
      'products': instance.products.map((e) => e.toJson()).toList(),
    };
