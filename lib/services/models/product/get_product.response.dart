import 'package:firesafe_vnex/models/supplier/supplier.short.model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../models/product/product.model.dart';

part 'get_product.response.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class GetProductResponse {
  GetProductResponse({required this.product,required this.supplier});

  factory GetProductResponse.fromJson(Map<String, dynamic> json) => _$GetProductResponseFromJson(json);

  final ProductModel product;
  final SupplierShortModel supplier;


  Map<String, dynamic> toJson() => _$GetProductResponseToJson(this);
}
