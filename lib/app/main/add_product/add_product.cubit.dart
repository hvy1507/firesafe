import 'dart:io';

import 'package:firesafe_vnex/app/main/add_product/add_product.state.dart';
import 'package:firesafe_vnex/components/commons/product_categories.dart';
import 'package:firesafe_vnex/models/country/country.model.dart';
import 'package:firesafe_vnex/models/enum_values/load_state.dart';
import 'package:firesafe_vnex/repository/country.repo.dart';
import 'package:firesafe_vnex/repository/supplier.repo.dart';
import 'package:firesafe_vnex/services/base_services.dart';
import 'package:firesafe_vnex/utils/extensions/cubit.ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductCubit extends Cubit<AddProductState> with BaseCubit {
  AddProductCubit(this._countryRepository, this._supplierRepository) : super(const AddProductState()) {
    load();
  }

  final SupplierRepository _supplierRepository;
  final CountryRepository _countryRepository;

  Future<void> load() async {
    try {
      safeEmit(state.copyWith(
        loadState: LoadState.loading,
      ));
      final countries = await _countryRepository.getAllCountry();
      safeEmit(state.copyWith(
        loadState: LoadState.loaded,
        countries: countries,
      ));
    } on RequestException catch (e) {
      safeEmit(state.copyWith(
        loadState: LoadState.error,
        error: e.message,
      ));
    }
  }

  bool validate() {
    return true;
  }

  Future<void> addProduct() async {
    final newPid = await _supplierRepository.addProduct(
      name: state.name,
      originId: state.originId,
      brand: state.brand,
      model: state.model,
      shortDescription: state.shortDescription,
      available: state.available,
      warranty: state.warranty,
      packaging: state.packaging,
      shippingTime: state.shippingTime,
      hasSample: state.hasSample,
      productionRate: state.productionRate,
      accessories: state.accessories,
      postSupport: state.postSupport,
      faq: state.faq,
      shape: state.shape,
      color: state.color,
      material: state.material,
      weight: state.weight,
      volume: state.volume,
      structure: state.structure,
      fireResistant: state.fireResistant,
      waterResistant: state.waterResistant,
      applications: state.application,
      additionalSpecification: state.additionalSpecification,
      price: state.price,
      priceMax: state.maxPrice,
      priceMin: state.minPrice,
      categories: state.categories.map((e) => e.toString()).toList(),
      thumbnailPath: state.thumbnail!.path,
      imagePaths: state.images?.map((e) => e.path).toList(),
      videoPaths: null, // TODO: add videos
      certificateNames: state.certificates.map((e) => e.$1).toList(),
      certificateImagePaths: state.certificates.map((e) => e.$2.path).toList(),
    );
    safeEmit(state.copyWith(
      newProductId: newPid,
    ));
  }

  void addCategory(Category category) {
    safeEmit(state.copyWith(
      categories: [...state.categories, category],
    ));
  }

  void removeCategory(Category category) {
    safeEmit(state.copyWith(
      categories: [...state.categories]..remove(category),
    ));
  }

  void setName(String name) {
    safeEmit(state.copyWith(
      name: name,
    ));
  }

  void setPrice({int? price, int? maxPrice, int? minPrice}) {
    safeEmit(state.copyWith(
      price: price == -1 ? null : price ?? state.price,
      maxPrice: maxPrice == -1 ? null : maxPrice ?? state.maxPrice,
      minPrice: minPrice == -1 ? null : minPrice ?? state.minPrice,
    ));
  }

  void setOriginId(CountryModel country) {
    safeEmit(state.copyWith(
      originId: country.id,
    ));
  }

  void setBrand(String brand) {
    safeEmit(state.copyWith(
      brand: brand,
    ));
  }

  void setModel(String model) {
    safeEmit(state.copyWith(
      model: model,
    ));
  }

  void setShortDescription(String description) {
    safeEmit(state.copyWith(
      shortDescription: description,
    ));
  }

  void setAvailable({bool value = true}) {
    safeEmit(state.copyWith(
      available: value,
    ));
  }

  void setWarranty(int warranty) {
    safeEmit(state.copyWith(
      warranty: warranty,
    ));
  }

  void setPackaging(String packaging) {
    safeEmit(state.copyWith(
      packaging: packaging,
    ));
  }

  void setShippingTime(int time) {
    safeEmit(state.copyWith(
      shippingTime: time,
    ));
  }

  void setHasSample(String sample) {
    safeEmit(state.copyWith(hasSample: sample));
  }

  void setProductionRate(String rate) {
    safeEmit(state.copyWith(
      productionRate: rate,
    ));
  }

  void setThumbnail(File file) {
    safeEmit(state.copyWith(
      thumbnail: file,
    ));
  }

  void addImages(List<File> files) {
    safeEmit(state.copyWith(
      images: [
        ...?state.images,
        ...files,
      ],
    ));
  }

  void removeImage(File file) {
    if (state.images != null) {
      final list = [...state.images!]..remove(file);
      safeEmit(
        state.copyWith(
          images: list.isEmpty ? null : list,
        ),
      );
    }
  }

  void setAccessories(String? accessories) {
    safeEmit(state.copyWith(
      accessories: accessories,
    ));
  }

  void setPostSupport(String? support) {
    safeEmit(state.copyWith(
      postSupport: support,
    ));
  }

  void setFaq(String? faq) {
    safeEmit(state.copyWith(
      faq: faq,
    ));
  }

  void setShape(String? shape) {
    safeEmit(state.copyWith(
      shape: shape,
    ));
  }

  void setColor(String? color) {
    safeEmit(state.copyWith(
      color: color,
    ));
  }

  void setMaterial(String? material) {
    safeEmit(state.copyWith(
      material: material,
    ));
  }

  void setWeight(int? weight) {
    safeEmit(state.copyWith(
      weight: weight,
    ));
  }

  void setVolume(int? volume) {
    safeEmit(state.copyWith(volume: volume));
  }

  void setStructure(String? structure) {
    safeEmit(state.copyWith(
      structure: structure,
    ));
  }

  void setFireResistant(String? resistant) {
    safeEmit(state.copyWith(
      fireResistant: resistant,
    ));
  }

  void setWaterResistant(String? resistant) {
    safeEmit(state.copyWith(
      waterResistant: resistant,
    ));
  }

  void setApplication(String? application) {
    safeEmit(state.copyWith(
      application: application,
    ));
  }

  void addAdditionalField(String key, String value) {
    safeEmit(state.copyWith(additionalSpecification: {
      ...?state.additionalSpecification,
      key: value,
    }));
  }

  void removeAdditionalField(String key) {
    if (state.additionalSpecification != null) {
      final map = {
        ...state.additionalSpecification!,
      }..remove(key);
      safeEmit(state.copyWith(
        additionalSpecification: map.isEmpty ? null : map,
      ));
    }
  }

  void addCertificate(File image, String name) {
    safeEmit(state.copyWith(
      certificates: [
        ...state.certificates,
        (name, image),
      ],
    ));
  }

  void removeCertificate((String, File) entry) {
    safeEmit(state.copyWith(
        certificates: [
          ...state.certificates,
        ]..remove(entry),
    ));
  }
}
