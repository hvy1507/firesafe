
import 'package:firesafe_vnex/models/product/product.model.dart';
import 'package:firesafe_vnex/models/product/product.short.model.dart';
import 'package:firesafe_vnex/models/supplier/supplier.short.model.dart';

abstract class ProductRepository {
  Future<List<ProductShortModel>> getProductsByPage({required String category, required int page});

  Future<List<ProductShortModel>> searchProduct(String query, {
    int page = 1,
    List<String>? categories,
    int? year,
    int? rating,
    int? minPrice,
    int? maxPrice,
  });

  Future<(ProductModel,SupplierShortModel)> getProduct(String id);
}