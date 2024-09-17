import 'package:firesafe_vnex/app/supplier/supplier_info.state.dart';
import 'package:firesafe_vnex/models/enum_values/load_state.dart';
import 'package:firesafe_vnex/repository/supplier.repo.dart';
import 'package:firesafe_vnex/services/base_services.dart';
import 'package:firesafe_vnex/utils/extensions/cubit.ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SupplierInfoCubit extends Cubit<SupplierInfoState> with BaseCubit{
  SupplierInfoCubit(this._supplierRepository, this.id) : super(const SupplierInfoState()) {
    getSupplierInfo();
  }

  final SupplierRepository _supplierRepository;
  final String id;

  int _currentPage = 1;
  bool _canLoadMore = true;

  Future<void> getSupplierInfo() async {
    safeEmit(state.copyWith(loadState: LoadState.loading));
    try {
      final result = await _supplierRepository.getSupplier(id);
      final products = await _supplierRepository.getSupplierProducts(id: id);
      safeEmit(state.copyWith(
        info: result,
        loadState: LoadState.loaded,
        products: products,
      ));
    } on RequestException catch (e) {
      safeEmit(state.copyWith(error: e.message, loadState: LoadState.error));
    }
  }

  Future<void> reloadSupplierProducts() async {
    safeEmit(state.copyWith(products: [], loadState: LoadState.loading));
    try {
      _currentPage = 1;
      final result = await _supplierRepository.getSupplierProducts(id: id);
      safeEmit(state.copyWith(
        products: result,
        loadState: LoadState.loaded,
        currentPage: _currentPage,
      ));
    } on RequestException catch (e) {
      safeEmit(state.copyWith(error: e.message, loadState: LoadState.error));
    }
  }

  Future<void> loadMore() async {
    if (!_canLoadMore) {
      return;
    }
    try {
      _currentPage++;
      safeEmit(state.copyWith(currentPage: _currentPage, loadState: LoadState.loading));
      final result = await _supplierRepository.getSupplierProducts(
        page: _currentPage,
      );
      if (result.length < 10) {
        _canLoadMore = false;
      }
      safeEmit(state.copyWith(
        products: [
          ...state.products,
          ...result,
        ],
        loadState: LoadState.loaded,
      ));
    } on RequestException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      safeEmit(state.copyWith(products: [], currentPage: _currentPage));
    }
  }
}
