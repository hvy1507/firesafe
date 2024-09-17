// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_userdata.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserDataResponse _$GetUserDataResponseFromJson(Map<String, dynamic> json) =>
    GetUserDataResponse(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetUserDataResponseToJson(
        GetUserDataResponse instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
    };
