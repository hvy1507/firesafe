// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier.short.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierShortModel _$SupplierShortModelFromJson(Map<String, dynamic> json) =>
    SupplierShortModel(
      id: json['supplierId'] as String,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      banner: json['banner'] as String?,
    );

Map<String, dynamic> _$SupplierShortModelToJson(SupplierShortModel instance) =>
    <String, dynamic>{
      'supplierId': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'banner': instance.banner,
    };
