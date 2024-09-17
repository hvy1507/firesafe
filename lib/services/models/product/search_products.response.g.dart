// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_products.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchProductsResponse _$SearchProductsResponseFromJson(
        Map<String, dynamic> json) =>
    SearchProductsResponse(
      result: (json['result'] as List<dynamic>)
          .map((e) => ProductShortModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchProductsResponseToJson(
        SearchProductsResponse instance) =>
    <String, dynamic>{
      'result': instance.result.map((e) => e.toJson()).toList(),
    };
