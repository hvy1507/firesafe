import 'package:firesafe_vnex/models/product/product.short.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_supplier_products.response.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class GetSupplierProductsResponse {
  GetSupplierProductsResponse({required this.products});

  factory GetSupplierProductsResponse.fromJson(Map<String, dynamic> json) => _$GetSupplierProductsResponseFromJson(json);

  final List<ProductShortModel> products;

  Map<String, dynamic> toJson() => _$GetSupplierProductsResponseToJson(this);
}
