// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_supplier_profile.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSupplierProfileResponse _$GetSupplierProfileResponseFromJson(
        Map<String, dynamic> json) =>
    GetSupplierProfileResponse(
      supplier:
          SupplierModel.fromJson(json['supplier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetSupplierProfileResponseToJson(
        GetSupplierProfileResponse instance) =>
    <String, dynamic>{
      'supplier': instance.supplier.toJson(),
    };
