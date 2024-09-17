import 'dart:async';

import 'package:firesafe_vnex/database/dao/country_dao.dart';
import 'package:firesafe_vnex/database/dao/search_history_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FiresafeDatabase {
  FiresafeDatabase._();

  static late final Database _database;

  static Future<void> initDatabase() async {
    final path = join(await getDatabasesPath(), 'firesafe.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE ${SearchHistoryDao.searchHistory} (
           query varchar(100) PRIMARY KEY,
           timestamp datetime AUTO_INCREMENT
        )
      ''');
        await db.execute('''
        CREATE TABLE ${CountryDao.country} (
          id varchar(2) PRIMARY KEY,
          name varchar(50)
        )
      ''');
      },
    );
  }

  static final searchHistoryDao = SearchHistoryDao(_database);
  static final countryDao = CountryDao(_database);
}
