import 'package:firesafe_vnex/models/country/country.model.dart';
import 'package:sqflite/sqflite.dart';

class CountryDao {
  CountryDao(this._database);

  static const String country = 'country';

  final Database _database;

  Future<List<CountryModel>> getAll() async {
    return (await _database.query(country)).map(
      (e) {
        return CountryModel.fromJson(e);
      },
    ).toList();
  }

  Future<CountryModel> get(String id) async {
    final result = await _database.query(
      country,
      where: 'id = $id',
    );
    return CountryModel.fromJson(result.first);
  }

  Future<void> addAll(List<CountryModel> list) async {
    for (final element in list) {
      await _database.insert(
        country,
        {
          'id': element.id,
          'name': element.name,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore
      );
    }
  }
}
