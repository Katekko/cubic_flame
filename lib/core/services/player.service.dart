import 'package:cubic_flame/core/libs/rest.lib.dart';
import 'package:cubic_flame/core/models/player.model.dart';
import 'package:flutter/foundation.dart';

class PlayerService {
  final RestLib _rest = RestLib();

  Future<PlayerModel> getPlayer({@required String uid}) async {
    try {
      String url = 'player/$uid';
      dynamic playerJson = await _rest.get(url: url);
      return PlayerModel.fromJson(playerJson);
    } catch (err) {
      rethrow;
    }
  }

  Future<bool> checkNickExists({@required String nick}) async {
    try {
      String url = 'player/check-nick/$nick';
      dynamic exists = await _rest.get(url: url);
      return exists;
    } catch (err) {
      rethrow;
    }
  }

  Future<bool> postCriarPlayer({@required PlayerModel player}) async {
    try {
      String url = 'player/create';
      await _rest.post(url: url, body: player.toJson());
      return true;
    } catch (err) {
      rethrow;
    }
  }
}
