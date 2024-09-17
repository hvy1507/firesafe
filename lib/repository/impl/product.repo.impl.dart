import 'package:dio/dio.dart';
import 'package:firesafe_vnex/models/product/product.model.dart';
import 'package:firesafe_vnex/models/product/product.short.model.dart';
import 'package:firesafe_vnex/repository/product.repo.dart';
import 'package:firesafe_vnex/services/impl/product.service.dart';
import 'package:firesafe_vnex/services/impl/supplier.services.dart';

import '../../models/supplier/supplier.short.model.dart';

class ProductRepositoryImpl extends ProductRepository {
  final _productService = ProductService();

  @override
  Future<List<ProductShortModel>> getProductsByPage({required String category, required int page}) async {
    final result = await _productService.getProductsCategory(category: category, page: page);
    return result.products;
  }

  @override
  Future<(ProductModel, SupplierShortModel)> getProduct(String id) async {
    final result = await _productService.getProduct(id);
    return (result.product, result.supplier);
  }

  @override
  Future<List<ProductShortModel>> searchProduct(
    String query, {
    int page = 1,
    List<String>? categories,
    int? year,
    int? rating,
    int? maxPrice,
    int? minPrice,
  }) async {
    final result = await _productService.searchProducts(
      query,
      page: page,
      categories: categories,
      year: year,
      rating: rating,
      priceRange: maxPrice != null && minPrice != null ? [maxPrice, minPrice] : null,
    );
    return result.result;
  }
}
