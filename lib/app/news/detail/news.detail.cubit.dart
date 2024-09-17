import 'package:firesafe_vnex/app/news/detail/news.details.state.dart';
import 'package:firesafe_vnex/repository/newspaper.repo.dart';
import 'package:firesafe_vnex/services/base_services.dart';
import 'package:firesafe_vnex/utils/extensions/cubit.ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsDetailCubit extends Cubit<NewsDetailState> with BaseCubit {
  NewsDetailCubit(
    this._newspaperRepository,
    this.id,
  ) : super(const NewsDetailLoading()) {
    getNewsDetail();
  }

  final String id;
  final NewspaperRepository _newspaperRepository;

  Future<void> getNewsDetail() async {
    safeEmit(
      const NewsDetailLoading(),
    );
    try {
      final result = await _newspaperRepository.getNewsDetail(id);
      safeEmit(
        NewsDetailSuccess(result),
      );
    } on RequestException catch (e) {
      safeEmit(
        NewsDetailError(e.message),
      );
    }
  }
}
