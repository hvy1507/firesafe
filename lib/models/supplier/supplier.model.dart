import 'package:json_annotation/json_annotation.dart';

part 'supplier.model.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class SupplierModel {
  SupplierModel({
    required this.id,
    this.name,
    this.description,
    required this.establishedAt,
    required this.rating,
    this.avatar,
    this.banner,
    this.address,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) => _$SupplierModelFromJson(json);

  @JsonKey(name: 'supplierId')
  final String id;
  final String? name;
  final String? description;
  final String? establishedAt;
  final int rating;
  final String? avatar;
  final String? banner;
  final String? address;

  Map<String, dynamic> toJson() => _$SupplierModelToJson(this);
}
