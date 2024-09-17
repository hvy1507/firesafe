import 'package:firesafe_vnex/database/firesafe_database.dart';
import 'package:firesafe_vnex/models/enum_values/load_state.dart';
import 'package:firesafe_vnex/repository/product.repo.dart';
import 'package:firesafe_vnex/services/base_services.dart';
import 'package:firesafe_vnex/utils/extensions/cubit.ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../components/commons/product_categories.dart';
import 'search.state.dart';

class SearchCubit extends Cubit<SearchState> with BaseCubit {
  SearchCubit(this._productRepository)
      : super(const SearchState(
          loadState: LoadState.idle,
          query: '',
          error: '',
          result: [],
          searchHistory: [],
          currentPage: 1,
        )) {
    getSearchHistory();
  }

  final ProductRepository _productRepository;

  String query = '';
  SearchOption? searchOption;

  int _currentPage = 1;
  bool _canLoadMore = true;

  Future<void> getSearchHistory() async {
    safeEmit(state.copyWith(loadState: LoadState.loading));
    try {
      final result = await FiresafeDatabase.searchHistoryDao.getAll();
      safeEmit(state.copyWith(
        loadState: LoadState.idle,
        searchHistory: result,
      ));
    } catch (_) {
      safeEmit(state.copyWith(loadState: LoadState.idle, searchHistory: []));
    }
  }

  Future<void> getResult() async {
    if (query.isEmpty) {
      return;
    }
    try {
      _currentPage = 1;
      _canLoadMore = true;
      safeEmit(state.copyWith(query: query, loadState: LoadState.loading));
      final result = await _productRepository.searchProduct(
        query,
        categories: searchOption?.categories.map((e) => e.toString()).toList(),
        year: searchOption?.year,
        rating: searchOption?.rating,
        minPrice: searchOption?.minPrice,
        maxPrice: searchOption?.maxPrice,
      );
      safeEmit(state.copyWith(loadState: LoadState.loaded, result: result));
    } on RequestException catch (e) {
      safeEmit(state.copyWith(loadState: LoadState.error, error: e.message));
    }
  }

  Future<void> loadMore() async {
    if (!_canLoadMore) {
      return;
    }
    try {
      _currentPage++;
      safeEmit(state.copyWith(currentPage: 1));
      final result = await _productRepository.searchProduct(
        query,
        page: _currentPage,
        categories: searchOption?.categories.map((e) => e.toString()).toList(),
        year: searchOption?.year,
        rating: searchOption?.rating,
        minPrice: searchOption?.minPrice,
        maxPrice: searchOption?.maxPrice,
      );
      if (result.length < 10) {
        _canLoadMore = false;
      }
      safeEmit(state.copyWith(result: result, currentPage: _currentPage));
    } on RequestException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      safeEmit(state.copyWith(result: [], currentPage: _currentPage));
    }
  }
}

class SearchOption {
  SearchOption._({this.categories = const [], this.year, this.minPrice, this.maxPrice, this.rating});

  final List<Category> categories;
  final int? year;
  final int? minPrice;
  final int? maxPrice;
  final int? rating;

  static SearchOptionBuilder builder() {
    return SearchOptionBuilder();
  }
}

class SearchOptionBuilder {
  final _categories = <Category>{};

  int? _year;
  int? _minPrice;
  int? _maxPrice;
  int? _rating;

  List<Category> get categories => _categories.toList();

  int? get year => _year;

  int? get minPrice => _minPrice;

  int? get maxPrice => _maxPrice;

  int? get rating => _rating;

  SearchOption build() {
    return SearchOption._(categories: _categories.toList(), year: _year, minPrice: _minPrice, maxPrice: _maxPrice, rating: _rating);
  }

  SearchOptionBuilder addCategory(Category category) {
    _categories.add(category);
    return this;
  }

  SearchOptionBuilder reset() {
    _categories.clear();
    _year = null;
    _rating = null;
    _maxPrice = null;
    _minPrice = null;
    return this;
  }

  SearchOptionBuilder removeCategory(Category category) {
    _categories.remove(category);
    return this;
  }

  SearchOptionBuilder addYear(int year) {
    _year = year;
    return this;
  }

  SearchOptionBuilder addPriceRange(int min, int max) {
    _minPrice = min;
    _maxPrice = max;
    return this;
  }

  SearchOptionBuilder addRating(int rating) {
    _rating = rating;
    return this;
  }
}
