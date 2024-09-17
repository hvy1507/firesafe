import 'package:firesafe_vnex/services/base_services.dart';

import '../endpoints.dart';
import '../models/product/get_product.response.dart';
import '../models/product/get_products_category.response.dart';
import '../models/product/search_products.response.dart';

class ProductService extends BaseService {
  Future<GetProductByCategoryResponse> getProductsCategory({required String category, required int page}) async {
    return GetProductByCategoryResponse.fromJson((await getResult(
      endpoints.product.getProductsCategory,
      requestType: RequestType.GET,
      query: {
        'category': category,
        'page': page,
      },
    ))!);
  }

  Future<GetProductResponse> getProduct(String id) async {
    return GetProductResponse.fromJson((await getResult(
      endpoints.product.getProduct,
      requestType: RequestType.GET,
      query : {
        'id' : id,
      }
    ))!);
  }

  Future<SearchProductsResponse> searchProducts(
    String query, {
    int page = 1,
    List<String>? categories,
    int? year,
    int? rating,
    List<int>? priceRange,
  }) async {
    return SearchProductsResponse.fromJson((await getResult(
      endpoints.product.searchProduct,
      requestType: RequestType.GET,
      query: {
        'query': query,
        'page': page,
        if (categories != null) 'categories': categories.join(';'),
        if (year != null) 'year': year,
        if (rating != null) 'rating': rating,
        if (priceRange != null) 'priceRange': priceRange.join(';'),
      },
    ))!);
  }
}
