import 'package:firesafe_vnex/models/product/product.model.dart';
import 'package:firesafe_vnex/models/product/product.short.model.dart';
import 'package:firesafe_vnex/models/supplier/supplier.short.model.dart';
import 'package:firesafe_vnex/repository/product.repo.dart';

class ProductRepositoryMock extends ProductRepository {
  @override
  Future<(ProductModel, SupplierShortModel)> getProduct(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductShortModel>> getProductsByPage({required String category, required int page}) async {
    return [
      ProductShortModel(
          productId: '122222121212',
          thumbnail: 'https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png',
          name: 'Cửa cuốn chống cháy ',
          price: 1000,
          priceMax: null,
          priceMin: null),
      ProductShortModel(
          productId: '122222121212',
          thumbnail: 'https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png',
          name: 'Cửa cuốn chống cháy ',
          price: 1000,
          priceMax: null,
          priceMin: null),
      ProductShortModel(
          productId: '122222121212',
          thumbnail: 'https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png',
          name: 'Cửa cuốn chống cháy ',
          price: 1000,
          priceMax: null,
          priceMin: null),
      ProductShortModel(
          productId: '122222121212',
          thumbnail: 'https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png',
          name: 'Cửa cuốn chống cháy ',
          price: 1000,
          priceMax: null,
          priceMin: null),
      ProductShortModel(
          productId: '122222121212',
          thumbnail: 'https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png',
          name: 'Cửa cuốn chống cháy ',
          price: 1000,
          priceMax: null,
          priceMin: null),
      ProductShortModel(
          productId: '122222121212',
          thumbnail: 'https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png',
          name: 'Cửa cuốn chống cháy ',
          price: 1000,
          priceMax: null,
          priceMin: null),
      ProductShortModel(
          productId: '122222121212',
          thumbnail: 'https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png',
          name: 'Cửa cuốn chống cháy ',
          price: 1000,
          priceMax: null,
          priceMin: null),
      ProductShortModel(
          productId: '122222121212',
          thumbnail: 'https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png',
          name: 'Cửa cuốn chống cháy ',
          price: 1000,
          priceMax: null,
          priceMin: null),
      ProductShortModel(
          productId: '122222121212',
          thumbnail: 'https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png',
          name: 'Cửa cuốn chống cháy ',
          price: 1000,
          priceMax: null,
          priceMin: null),
      ProductShortModel(
          productId: '122222121212',
          thumbnail: 'https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png',
          name: 'Cửa cuốn chống cháy ',
          price: 1000,
          priceMax: null,
          priceMin: null),
    ];
  }

  @override
  Future<List<ProductShortModel>> searchProduct(String query,
      {int page = 1, List<String>? categories, int? year, int? rating, int? maxPrice, int? minPrice}) {
    throw UnimplementedError();
  }
}
