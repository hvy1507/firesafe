import 'package:firesafe_vnex/models/enum_values/load_state.dart';
import 'package:firesafe_vnex/repository/country.repo.dart';
import 'package:firesafe_vnex/repository/product.repo.dart';
import 'package:firesafe_vnex/services/base_services.dart';
import 'package:firesafe_vnex/utils/extensions/cubit.ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_detail.state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> with BaseCubit {
  ProductDetailCubit(
    this._countryRepository,
    this._productRepository,
    this.productId,
  ) : super(const ProductDetailState()) {
    getDetail();
  }

  final CountryRepository _countryRepository;
  final ProductRepository _productRepository;
  final String productId;

  Future<void> getDetail([int page = 1]) async {
    safeEmit(state.copyWith(loadState: LoadState.loading));
    try {
      final result = await _productRepository.getProduct(productId);
      final origin = await _countryRepository.getById(result.$1.originId);
      final List<String> combined = [
        result.$1.thumbnail,
        if (result.$1.images != null)
          ...result.$1.images!,
      ];
      safeEmit(state.copyWith(
        supplier: result.$2,
        product: result.$1,
        loadState: LoadState.loaded,
        countryName: origin,
        combinedList: combined,
      ));
    } on RequestException catch (e) {
      safeEmit(state.copyWith(
        loadState: LoadState.error,
        error: e.message,
      ));
    }
  }
}
