import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

part 'player.dao.dart';

class UsuarioModel {
  Database db;
  UsuarioModel() {
    db = GetIt.I.get();
  }

  Future<int> insertUser({
    @required String uid,
    @required String nick,
    @required String email,
    @required int gold,
  }) async {
    try {
      await db.transaction((txn) async {
        _PlayerDAO dao = _PlayerDAO(
          uid: uid,
          nick: nick,
          email: email,
          gold: gold,
        );

        dao.insert(txn);
      });
    } catch (err) {
      rethrow;
    }
  }
}
