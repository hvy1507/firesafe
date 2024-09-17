import 'package:json_annotation/json_annotation.dart';

part 'supplier.short.model.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class SupplierShortModel {
  SupplierShortModel({
    required this.id,
    this.name,
    this.avatar,
    this.banner,
  });

  factory SupplierShortModel.fromJson(Map<String, dynamic> json) => _$SupplierShortModelFromJson(json);
  @JsonKey(name: 'supplierId')
  final String id;
  final String? name;
  final String? avatar;
  final String? banner;

  Map<String, dynamic> toJson() => _$SupplierShortModelToJson(this);
}
