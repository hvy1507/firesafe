import 'package:firesafe_vnex/models/newspaper/newspaper.model.dart';
import 'package:firesafe_vnex/models/newspaper/newspaper.short.model.dart';

abstract class NewspaperRepository {
  Future<List<NewspaperShortModel>> getAllNews();

  Future<List<NewspaperShortModel>> getNewNews();

  Future<List<NewspaperShortModel>> getNewsByProductCategory();

  Future<List<NewspaperShortModel>> getNewsByField();

  Future<NewspaperModel> getNewsDetail(String id);
}
