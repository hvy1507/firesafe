// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_newspaper.short.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNewspaperShortResponse _$GetNewspaperShortResponseFromJson(
        Map<String, dynamic> json) =>
    GetNewspaperShortResponse(
      newspapers: (json['newspapers'] as List<dynamic>)
          .map((e) => NewspaperShortModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetNewspaperShortResponseToJson(
        GetNewspaperShortResponse instance) =>
    <String, dynamic>{
      'newspapers': instance.newspapers.map((e) => e.toJson()).toList(),
    };
