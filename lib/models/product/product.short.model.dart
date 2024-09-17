import 'package:json_annotation/json_annotation.dart';

part 'product.short.model.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class ProductShortModel {
  ProductShortModel({
    required this.productId,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.priceMax,
    required this.priceMin,
  });

  factory ProductShortModel.fromJson(Map<String, dynamic> json) => _$ProductShortModelFromJson(json);

  final String productId;
  final String name;
  final String thumbnail;
  final int? price;
  final int? priceMax;
  final int? priceMin;

  Map<String, dynamic> toJson() => _$ProductShortModelToJson(this);
}
