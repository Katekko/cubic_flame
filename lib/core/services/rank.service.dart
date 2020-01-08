import 'package:cubic_flame/core/libs/rest.lib.dart';
import 'package:cubic_flame/core/models/enviar_score.model.dart';
import 'package:cubic_flame/core/models/rank.model.dart';
import 'package:flutter/foundation.dart';

class RankService {
  RestLib _rest;

  RankService() {
    _rest = RestLib();
  }

  Future<List<RankModel>> getRank() async {
    try {
      String url = 'rank';
      dynamic ranksJson = await _rest.get(url: url);
      List<RankModel> ranks = [];
      ranksJson.forEach(
        (rank) => ranks.add(
          RankModel.fromJson(rank),
        ),
      );
      return ranks;
    } catch (err) {
      rethrow;
    }
  }

  Future<bool> enviarScore({@required EnviarScoreModel model}) async {
    try {
      String url = 'rank/enviar-score';
      dynamic resultJson = await _rest.post(url: url, body: model.toJson());
      return resultJson;
    } catch (err) {
      rethrow;
    }
  }

  Future<bool> checkNameExist({
    @required String name,
    @required String uid,
  }) async {
    try {
      String url = 'rank/check-name/' + name + '/' + uid;
      dynamic ranksJson = await _rest.get(url: url);
      return ranksJson;
    } catch (err) {
      rethrow;
    }
  }
}
