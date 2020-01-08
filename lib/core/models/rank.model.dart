import 'package:cubic_flame/core/models/player.model.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rank.model.g.dart';

@JsonSerializable()
class RankModel extends PlayerModel {
  int score;
  RankModel({
    uid,
    email,
    nick,
    skins,
    @required this.score,
  }) : super(uid: uid, email: email, nick: nick, skins: skins);

  factory RankModel.fromJson(Map<String, dynamic> json) =>
      _$RankModelFromJson(json);

  Map<String, dynamic> toJson() => _$RankModelToJson(this);
}
