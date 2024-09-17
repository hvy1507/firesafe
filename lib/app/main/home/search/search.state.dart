import 'package:firesafe_vnex/models/enum_values/load_state.dart';
import 'package:firesafe_vnex/models/product/product.short.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search.state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    required LoadState loadState,
    required String query,
    required List<String> searchHistory,
    required List<ProductShortModel> result,
    required String? error,
    required int currentPage
  }) = _SearchState;
}

// class SearchInitial extends SearchState {
//   const SearchInitial();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class SearchError extends SearchState {
//   const SearchError(this.message);
//
//   final String message;
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class SearchLoading extends SearchState {
//   const SearchLoading(this.page);
//
//   final int page;
//
//   @override
//   List<Object?> get props => [];
// }
//
// class SearchSuccess extends SearchState {
//   const SearchSuccess(this.products, this.page);
//
//   final List<ProductShortModel> products;
//   final int page;
//
//   @override
//   List<Object?> get props => [...products];
// }
