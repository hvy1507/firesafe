import 'package:firesafe_vnex/app/news/news.state.dart';
import 'package:firesafe_vnex/repository/newspaper.repo.dart';
import 'package:firesafe_vnex/services/base_services.dart';
import 'package:firesafe_vnex/utils/extensions/cubit.ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsState> with BaseCubit {
  NewsCubit(this._newspaperRepository) : super(const NewsLoading(NewspaperType.initial)) {
    loadAll();
  }

  final NewspaperRepository _newspaperRepository;

  Future<void> loadAll() async {
    await Future.wait([
      getNewNews(),
      getAllNews(),
      getNewsByProductCategory(),
      getNewsByField(),
    ]);
  }

  Future<void> getAllNews() async {
    safeEmit(
      const NewsLoading(NewspaperType.all),
    );
    try {
      final result = await _newspaperRepository.getAllNews();

      safeEmit(
        NewsSuccess(result, NewspaperType.all),
      );
    } on RequestException catch (e) {
      safeEmit(
        NewsError(e.message, NewspaperType.all),
      );
    }
  }

  Future<void> getNewNews() async {
    safeEmit(
      const NewsLoading(NewspaperType.news),
    );
    try {
      final result = await _newspaperRepository.getNewNews();
      safeEmit(
        NewsSuccess(result, NewspaperType.news),
      );
    } on RequestException catch (e) {
      safeEmit(
        NewsError(e.message, NewspaperType.news),
      );
    }
  }

  Future<void> getNewsByProductCategory() async {
    safeEmit(
      const NewsLoading(NewspaperType.category),
    );
    try {
      final result = await _newspaperRepository.getNewsByProductCategory();
      safeEmit(
        NewsSuccess(result, NewspaperType.category),
      );
    } on RequestException catch (e) {
      safeEmit(
        NewsError(e.message, NewspaperType.category),
      );
    }
  }

  Future<void> getNewsByField() async {
    safeEmit(
      const NewsLoading(NewspaperType.news),
    );
    try {
      final result = await _newspaperRepository.getNewsByField();
      safeEmit(
        NewsSuccess(result, NewspaperType.field),
      );
    } on RequestException catch (e) {
      safeEmit(
        NewsError(e.message, NewspaperType.field),
      );
    }
  }
}
