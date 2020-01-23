import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class SqlUtil {
  static Future<Database> createDatabaseModel() async {
    try {
      try {
        GetIt.I.unregister(instance: GetIt.I.get<Database>());
      } catch (_) {}

      Database db;
      var path = await _getDatabasePath();

      if (!await databaseExists(path)) {
        db = await openDatabase(
          path,
          version: 1,
          onCreate: (
            Database db,
            int version,
          ) async {
            _createSegPlayerTable(db);
          },
        );
      } else {
        db = await openDatabase(
          path,
          version: 1,
        );
      }

      GetIt.I.registerSingleton(db);
      return db;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  static Future<String> _getDatabasePath() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + '/database.db';

    await Directory(databasesPath).create(recursive: true);

    return path;
  }

  static void _createSegPlayerTable(db) async {
    await db.execute(
      '''
          CREATE TABLE Player (
            UID VARCHAR(64) PRIMARY KEY NOT NULL,
            nick VARCHAR(64) NOT NULL,
            email VARCHAR(64) NOT NULL,
            gold INT NOT NULL,
          )
      ''',
    );
  }
}
