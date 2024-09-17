import 'package:dio/dio.dart';
import 'package:firesafe_vnex/models/product/product.short.model.dart';
import 'package:firesafe_vnex/models/supplier/supplier.model.dart';
import 'package:firesafe_vnex/services/impl/supplier.services.dart';

import '../supplier.repo.dart';

class SupplierRepositoryImpl implements SupplierRepository {
  final _supplierService = SupplierService();

  @override
  Future<void> deleteProduct(String productId) async {
    await _supplierService.deleteProduct(productId);
  }

  @override
  Future<void> editProduct() {
    // TODO: implement editProduct
    throw UnimplementedError();
  }

  @override
  Future<void> editSupplierProfile({
    String? name,
    String? description,
    String? establishedAt,
    int? provinceId,
    String? avatarPath,
    String? bannerPath,
  }) async {
    await _supplierService.editProfile(
      name: name,
      description: description,
      establishedAt: establishedAt,
      provinceId: provinceId,
      avatar: avatarPath != null ? MultipartFile.fromFileSync(avatarPath) : null,
      banner: bannerPath != null ? MultipartFile.fromFileSync(bannerPath) : null,
    );
  }

  @override
  Future<SupplierModel> getSupplier([String? id]) async {
    return (await _supplierService.getProfile(id)).supplier;
  }

  @override
  Future<List<ProductShortModel>> getSupplierProducts({
    String? id,
    int page = 1,
  }) async {
    return (await _supplierService.getProducts(
      supplierId: id,
      page: page,
    ))
        .products;
  }

  @override
  Future<void> registerNewSupplier() async {
    await _supplierService.register();
  }

  @override
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
  }) async {
    final result = await _supplierService.addProduct(
      name: name,
      originId: originId,
      brand: brand,
      model: model,
      shortDescription: shortDescription,
      available: available,
      warranty: warranty,
      packaging: packaging,
      shippingTime: shippingTime,
      hasSample: hasSample,
      productionRate: productionRate,
      accessories: accessories,
      postSupport: postSupport,
      faq: faq,
      shape: shape,
      color: color,
      material: material,
      weight: weight,
      volume: volume,
      structure: structure,
      fireResistant: fireResistant,
      waterResistant: waterResistant,
      applications: applications,
      additionalSpecification: additionalSpecification,
      price: price,
      priceMax: priceMax,
      priceMin: priceMin,
      categories: categories,
      thumbnail: MultipartFile.fromFileSync(thumbnailPath),
      images: imagePaths?.map((file) => MultipartFile.fromFileSync(file)).toList(),
      videos: videoPaths?.map((file) => MultipartFile.fromFileSync(file)).toList(),
      certificateNames: certificateNames,
      certificateImages: certificateImagePaths.map((file) => MultipartFile.fromFileSync(file)).toList(),
    );
    return result.productId;
  }
}
