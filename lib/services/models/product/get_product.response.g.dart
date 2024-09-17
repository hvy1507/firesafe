// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_product.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductResponse _$GetProductResponseFromJson(Map<String, dynamic> json) =>
    GetProductResponse(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      supplier:
          SupplierShortModel.fromJson(json['supplier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetProductResponseToJson(GetProductResponse instance) =>
    <String, dynamic>{
      'product': instance.product.toJson(),
      'supplier': instance.supplier.toJson(),
    };
