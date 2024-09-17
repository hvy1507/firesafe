// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_country.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCountryResponse _$GetCountryResponseFromJson(Map<String, dynamic> json) =>
    GetCountryResponse(
      countries: (json['countries'] as List<dynamic>)
          .map((e) => CountryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCountryResponseToJson(GetCountryResponse instance) =>
    <String, dynamic>{
      'countries': instance.countries.map((e) => e.toJson()).toList(),
    };
