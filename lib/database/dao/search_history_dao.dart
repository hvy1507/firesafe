import 'package:sqflite/sqflite.dart';

class SearchHistoryDao {
  SearchHistoryDao(this._database);

  static const String searchHistory = 'search_history';

  final Database _database;

  Future<List<String>> getAll() async {
    return (await _database.query(
      searchHistory,
      orderBy: 'timestamp',
      columns: ['query'],
    ))
        .map((e) {
      return e['query'].toString();
    }).toList();
  }

  Future<void> add(String query) async {
    await _database.insert(
      searchHistory,
      {'query': query},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeAll() async {
    await _database.delete(
      searchHistory,
    );
  }
}
