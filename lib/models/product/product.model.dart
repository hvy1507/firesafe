import 'package:json_annotation/json_annotation.dart';

part 'product.model.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class ProductModel {
  ProductModel(
      this.originId,
      this.brand,
      this.model,
      this.shortDescription,
      this.available,
      this.certificates,
      this.warranty,
      this.packaging,
      this.shippingTime,
      this.hasSample,
      this.productionRate,
      this.accessories,
      this.postSupport,
      this.faq,
      this.shape,
      this.color,
      this.material,
      this.weight,
      this.volume,
      this.structure,
      this.fireResistant,
      this.waterResistant,
      this.applications,
      this.additionalSpecification,
      this.images,
      this.categories,
      this.productId,
      this.name,
      this.thumbnail,
      this.rating,
      this.price,
      this.priceMax,
      this.priceMin,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  final String originId;
  final String brand;
  final String model;
  final String shortDescription;
  final bool available;
  final List<Certificate> certificates;
  final int warranty;
  final String packaging;
  final int shippingTime;
  final String hasSample;
  final String productionRate;
  final String? accessories;
  final String? postSupport;
  final String? faq;
  final String? shape;
  final String? color;
  final String? material;
  final int? weight;
  final int? volume;
  final String? structure;
  final String? fireResistant;
  final String? waterResistant;
  final String? applications;
  final String? additionalSpecification;
  final List<String>? images;
  final List<String> categories;
  final String productId;
  final String name;
  final String thumbnail;
  final int rating;
  final int? price;
  final int? priceMax;
  final int? priceMin;

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class Certificate {
  Certificate(this.name, this.image);

  factory Certificate.fromJson(Map<String, dynamic> json) =>
      _$CertificateFromJson(json);

  final String name;
  final String image;

  Map<String, dynamic> toJson() => _$CertificateToJson(this);
}
