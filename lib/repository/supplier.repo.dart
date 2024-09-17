import 'package:firesafe_vnex/models/product/product.model.dart';
import 'package:firesafe_vnex/models/product/product.short.model.dart';
import 'package:firesafe_vnex/models/supplier/supplier.model.dart';

abstract interface class SupplierRepository {
  Future<void> registerNewSupplier();

  Future<void> editSupplierProfile();

  Future<SupplierModel> getSupplier([String? id]);

  Future<List<ProductShortModel>> getSupplierProducts({
    String? id,
    int page = 1,
  });

  Future<String> addProduct({
    required String name,
    required String originId,
    required String brand,
    required String model,
    required String shortDescription,
    required bool available,
    required int warranty,
    required String packaging,
    required int shippingTime,
    required String hasSample,
    required String productionRate,
    String? accessories,
    String? postSupport,
    String? faq,
    String? shape,
    String? color,
    String? material,
    int? weight,
    int? volume,
    String? structure,
    String? fireResistant,
    String? waterResistant,
    String? applications,
    Map<String, String>? additionalSpecification,
    required int? price,
    required int? priceMax,
    required int? priceMin,
    required List<String> categories,
    required String thumbnailPath,
    List<String>? imagePaths,
    List<String>? videoPaths,
    required List<String> certificateNames,
    required List<String> certificateImagePaths,
  });

  Future<void> editProduct();

  Future<void> deleteProduct(String productId);
}
