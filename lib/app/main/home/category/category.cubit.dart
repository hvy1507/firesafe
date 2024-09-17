import 'package:firesafe_vnex/repository/mocks/product.repo.mock.dart';
import 'package:firesafe_vnex/repository/product.repo.dart';
import 'package:firesafe_vnex/services/base_services.dart';
import 'package:firesafe_vnex/utils/extensions/cubit.ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'category.state.dart';

class CategoryCubit extends Cubit<CategoryState> with BaseCubit{
  CategoryCubit(this.productRepository, this.category, {this.page = 1}) : super(const CategoryLoading(1)) {
    getResult();
  }

  final ProductRepository productRepository;
  final String category;
  final int page;
  int _currentPage = 1;
  bool _canLoadMore = true;

  Future<void> getResult() async {
    try {
      _currentPage = 1;
      _canLoadMore = true;
      safeEmit(const CategoryLoading(1));
      final result = await productRepository.getProductsByPage(category: category, page: page);
      safeEmit(CategorySuccess(result, 1));
    } on RequestException catch (e) {
      safeEmit(
        CategoryError(e.message),
      );
    }
  }

  Future<void> loadMore() async {
    if (!_canLoadMore) {
      return;
    }
    try {
      _currentPage++;
      safeEmit(CategoryLoading(_currentPage));
      final result = await productRepository.getProductsByPage(category: category, page: page);
      if (result.length < 10) {
        _canLoadMore = false;
      }
      safeEmit(
        CategorySuccess(result, _currentPage),
      );
    } on RequestException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      safeEmit(
        CategorySuccess(const [], _currentPage),
      );
    }
  }
}
