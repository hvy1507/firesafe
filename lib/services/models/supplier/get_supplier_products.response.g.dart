// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_supplier_products.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSupplierProductsResponse _$GetSupplierProductsResponseFromJson(
        Map<String, dynamic> json) =>
    GetSupplierProductsResponse(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductShortModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSupplierProductsResponseToJson(
        GetSupplierProductsResponse instance) =>
    <String, dynamic>{
      'products': instance.products.map((e) => e.toJson()).toList(),
    };
