// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.short.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductShortModel _$ProductShortModelFromJson(Map<String, dynamic> json) =>
    ProductShortModel(
      productId: json['productId'] as String,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      price: json['price'] as int?,
      priceMax: json['priceMax'] as int?,
      priceMin: json['priceMin'] as int?,
    );

Map<String, dynamic> _$ProductShortModelToJson(ProductShortModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'price': instance.price,
      'priceMax': instance.priceMax,
      'priceMin': instance.priceMin,
    };
