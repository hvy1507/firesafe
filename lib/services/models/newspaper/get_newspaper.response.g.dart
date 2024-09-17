// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_newspaper.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNewspaperResponse _$GetNewspaperResponseFromJson(
        Map<String, dynamic> json) =>
    GetNewspaperResponse(
      newspaper:
          NewspaperModel.fromJson(json['newspaper'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetNewspaperResponseToJson(
        GetNewspaperResponse instance) =>
    <String, dynamic>{
      'newspaper': instance.newspaper.toJson(),
    };
