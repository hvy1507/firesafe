// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_roles.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllRolesResponse _$GetAllRolesResponseFromJson(Map<String, dynamic> json) =>
    GetAllRolesResponse(
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GetAllRolesResponseToJson(
        GetAllRolesResponse instance) =>
    <String, dynamic>{
      'roles': instance.roles,
    };
