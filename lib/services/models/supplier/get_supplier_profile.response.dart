import 'package:firesafe_vnex/models/supplier/supplier.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_supplier_profile.response.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class GetSupplierProfileResponse {
  GetSupplierProfileResponse({required this.supplier});

  factory GetSupplierProfileResponse.fromJson(Map<String, dynamic> json) => _$GetSupplierProfileResponseFromJson(json);

  final SupplierModel supplier;

  Map<String, dynamic> toJson() => _$GetSupplierProfileResponseToJson(this);
}
