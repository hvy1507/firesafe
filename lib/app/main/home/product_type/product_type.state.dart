import 'package:equatable/equatable.dart';

import '../../../../../models/product/product.short.model.dart';

sealed class ProductTypeState extends Equatable {
  const ProductTypeState();
}

class ProductTypeError extends ProductTypeState {
  const ProductTypeError(this.message);
  final String? message;

  @override
  List<Object?> get props => [];
}

class ProductTypeLoading extends ProductTypeState {
  const ProductTypeLoading();

  @override
  List<Object?> get props => [];
}

class ProductTypeSuccess extends ProductTypeState {
  const ProductTypeSuccess(this.products,{this.page = 1});

  final List<ProductShortModel> products;
  final int page;

  @override
  List<Object?> get props => [...products];
}
