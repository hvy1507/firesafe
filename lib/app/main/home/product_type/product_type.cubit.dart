import 'package:firesafe_vnex/repository/product.repo.dart';
import 'package:firesafe_vnex/services/base_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_type.state.dart';

class ProductTypeCubit extends Cubit<ProductTypeState> {
  ProductTypeCubit(this._productRepository, this.id) : super(const ProductTypeLoading()) {
    load();
  }

  final ProductRepository _productRepository;
  final String id;

  Future<void> load([int page = 1]) async {
    emit(const ProductTypeLoading());
    try {
      final result = await _productRepository.getProductsByPage(category: id, page: page);
      emit(ProductTypeSuccess(result));
    } on RequestException catch (e) {
      emit(ProductTypeError(e.message));
    }
  }
}
