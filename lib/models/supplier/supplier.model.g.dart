// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierModel _$SupplierModelFromJson(Map<String, dynamic> json) =>
    SupplierModel(
      id: json['supplierId'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      establishedAt: json['establishedAt'] as String?,
      rating: json['rating'] as int,
      avatar: json['avatar'] as String?,
      banner: json['banner'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$SupplierModelToJson(SupplierModel instance) =>
    <String, dynamic>{
      'supplierId': instance.id,
      'name': instance.name,
      'description': instance.description,
      'establishedAt': instance.establishedAt,
      'rating': instance.rating,
      'avatar': instance.avatar,
      'banner': instance.banner,
      'address': instance.address,
    };
