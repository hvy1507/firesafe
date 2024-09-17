import 'package:json_annotation/json_annotation.dart';

import '../../../models/product/product.short.model.dart';

part 'search_products.response.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class SearchProductsResponse {
  SearchProductsResponse({required this.result});

  factory SearchProductsResponse.fromJson(Map<String, dynamic> json) => _$SearchProductsResponseFromJson(json);

  final List<ProductShortModel> result;

  Map<String, dynamic> toJson() => _$SearchProductsResponseToJson(this);
}
