import 'package:json_annotation/json_annotation.dart';

import '../../../models/product/product.short.model.dart';

part 'get_products_category.response.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class GetProductByCategoryResponse {
  GetProductByCategoryResponse({required this.products});

  factory GetProductByCategoryResponse.fromJson(Map<String, dynamic> json) => _$GetProductByCategoryResponseFromJson(json);

  final List<ProductShortModel> products;

  Map<String, dynamic> toJson() => _$GetProductByCategoryResponseToJson(this);
}
