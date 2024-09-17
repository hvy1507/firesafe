import 'package:json_annotation/json_annotation.dart';

import '../../../models/product/product.model.dart';

part 'add_product.response.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class AddProductResponse {
  AddProductResponse({required this.productId});

  factory AddProductResponse.fromJson(Map<String, dynamic> json) => _$AddProductResponseFromJson(json);

  final String productId;

  Map<String, dynamic> toJson() => _$AddProductResponseToJson(this);
}
