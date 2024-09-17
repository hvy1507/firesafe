import 'package:equatable/equatable.dart';
import 'package:firesafe_vnex/models/product/product.short.model.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryError extends CategoryState {
  const CategoryError(this.message);

  final String message;

  @override
  List<Object?> get props => [];
}

class CategoryLoading extends CategoryState {
  const CategoryLoading(this.page);
  final int page;

  @override
  List<Object?> get props => [];
}

class CategorySuccess extends CategoryState {
  const CategorySuccess(this.products,this.page);

  final List<ProductShortModel> products;
  final int page;

  @override
  List<Object?> get props => [...products];
}
