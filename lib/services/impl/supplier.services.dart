import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firesafe_vnex/services/base_services.dart';

import '../endpoints.dart';
import '../models/product/add_product.response.dart';
import '../models/supplier/get_supplier_products.response.dart';
import '../models/supplier/get_supplier_profile.response.dart';

class SupplierService extends BaseService {
  Future<void> register() async {
    await getResult(
      endpoints.supplier.register,
      requestType: RequestType.POST,
    );
  }

  Future<void> editProfile({
    String? name,
    String? description,
    String? establishedAt,
    int? provinceId,
    MultipartFile? avatar,
    MultipartFile? banner,
  }) async {
    await getResult(
      endpoints.supplier.editProfile,
      requestType: RequestType.PUT,
      formData: {
        'name': name,
        'description': description,
        'establishedAt': establishedAt,
        'provinceId': provinceId,
        'avatar': avatar,
        'banner': banner,
      },
    );
  }

  Future<GetSupplierProfileResponse> getProfile([String? supplierId]) async {
    return GetSupplierProfileResponse.fromJson((await getResult(
      endpoints.supplier.getProfile,
      requestType: RequestType.GET,
      query: {
        'id': supplierId,
      },
    ))!);
  }

  Future<AddProductResponse> addProduct({
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
    required MultipartFile thumbnail,
    List<MultipartFile>? images,
    List<MultipartFile>? videos,
    required List<String> certificateNames,
    required List<MultipartFile> certificateImages,
  }) async {
    return AddProductResponse.fromJson((await getResult(
      endpoints.supplier.addProduct,
      requestType: RequestType.POST,
      formData: {
        'name': name,
        'originId': originId,
        'brand': brand,
        'model': model,
        'shortDescription': shortDescription,
        'available': available,
        'warranty': warranty,
        'packaging': packaging,
        'shippingTime': shippingTime,
        'hasSample': hasSample,
        'productionRate': productionRate,
        'accessories': accessories,
        'postSupport': postSupport,
        'faq': faq,
        'shape': shape,
        'color': color,
        'material': material,
        'weight': weight,
        'volume': volume,
        'structure': structure,
        'fireResistant': fireResistant,
        'waterResistant': waterResistant,
        'applications': applications,
        'additionalSpecification': additionalSpecification == null ? null : jsonEncode(additionalSpecification),
        'price': price,
        'priceMax': priceMax,
        'priceMin': priceMin,
        'categories': categories,
        'thumbnail': thumbnail,
        'images': images,
        'videos': videos,
        'certificateNames': certificateNames,
        'certificateImages': certificateImages,
      },
    ))!);
  }

  Future<void> editProduct() async {
    // TODO: Implement.
  }

  Future<GetSupplierProductsResponse> getProducts({
    String? supplierId,
    int page = 1,
  }) async {
    return GetSupplierProductsResponse.fromJson((await getResult(
      endpoints.supplier.getProducts,
      requestType: RequestType.GET,
      query: {
        'id': supplierId,
        'page': page,
      },
    ))!);
  }

  Future<void> deleteProduct(String productId) async {
    await getResult(
      endpoints.supplier.deleteProduct,
      requestType: RequestType.DELETE,
      query: {'id': productId},
    );
  }
}
