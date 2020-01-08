import 'package:cubic_flame/core/models/rank.model.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enviar_score.model.g.dart';

@JsonSerializable()
class EnviarScoreModel extends RankModel {
  String hashScore;
  String versaoApp;

  EnviarScoreModel({
    uid,
    email,
    @required nick,
    @required score,
    @required this.hashScore,
    @required skins,
    this.versaoApp,
  }) : super(uid: uid, email: email, nick: nick, score: score, skins: skins);

  @override
  factory EnviarScoreModel.fromJson(Map<String, dynamic> json) =>
      _$EnviarScoreModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EnviarScoreModelToJson(this);
}
