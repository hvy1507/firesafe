import 'package:equatable/equatable.dart';
import 'package:firesafe_vnex/models/newspaper/newspaper.short.model.dart';

abstract class NewsState extends Equatable {
  const NewsState(this.type);
  final NewspaperType type;

}

class NewsError extends NewsState {
  const NewsError(this.message,super.type);

  final String message;

  @override
  List<Object?> get props => [];
}

class NewsLoading extends NewsState {
  const NewsLoading(super.type);


  @override
  List<Object?> get props => [];
}

class NewsSuccess extends NewsState {
  const NewsSuccess(this.newspaper,super.type);


  final List<NewspaperShortModel> newspaper;

  @override
  List<Object?> get props => [...newspaper];
}


enum NewspaperType { initial ,news , all , category , field }

