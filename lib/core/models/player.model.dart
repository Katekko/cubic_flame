import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'skin.model.dart';

part 'player.model.g.dart';

@JsonSerializable()
class PlayerModel {
  String uid;
  String email;
  String nick;
  List<SkinModel> skins;
  double gold;

  PlayerModel({
    @required this.uid,
    @required this.email,
    @required this.nick,
    this.skins,
    this.gold,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);
}
