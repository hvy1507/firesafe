import 'package:equatable/equatable.dart';
import 'package:firesafe_vnex/models/newspaper/newspaper.model.dart';

abstract class NewsDetailState extends Equatable {
  const NewsDetailState();
}

class NewsDetailError extends NewsDetailState {
  const NewsDetailError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class NewsDetailLoading extends NewsDetailState {
  const NewsDetailLoading();

  @override
  List<Object?> get props => [];
}

class NewsDetailSuccess extends NewsDetailState {
  const NewsDetailSuccess(this.result);

  final NewspaperModel result;

  @override
  List<Object?> get props => [result];
}
