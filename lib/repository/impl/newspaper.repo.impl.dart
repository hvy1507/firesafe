import 'package:firesafe_vnex/models/newspaper/newspaper.model.dart';
import 'package:firesafe_vnex/models/newspaper/newspaper.short.model.dart';
import 'package:firesafe_vnex/repository/newspaper.repo.dart';
import 'package:firesafe_vnex/services/impl/newspaper.services.dart';

class NewspaperRepositoryImpl extends NewspaperRepository {
  final NewspaperService _newspaperService = NewspaperService();

  @override
  Future<List<NewspaperShortModel>> getAllNews() async {
    final result = await _newspaperService.getAllNews();
    return result.newspapers;
  }

  @override
  Future<List<NewspaperShortModel>> getNewNews() async {
    final result = await _newspaperService.getNewNews();
    return result.newspapers;
  }

  @override
  Future<List<NewspaperShortModel>> getNewsByField() async {
    final result = await _newspaperService.getNewsByField();
    return result.newspapers;
  }

  @override
  Future<List<NewspaperShortModel>> getNewsByProductCategory() async {
    final result = await _newspaperService.getNewsByProductCategory();
    return result.newspapers;
  }

  @override
  Future<NewspaperModel> getNewsDetail(String id) async {
    final result = await _newspaperService.getNewsDetail(id);
    return result.newspaper;
  }

// @override
// Future<NewspaperShortModel> getNewsDetail(String id)  async {
//   final result = await _newspaperService.getNewsDetail(id);
//   return result.newspaper;
// }
}
