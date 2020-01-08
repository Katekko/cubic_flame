// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) {
  return PlayerModel(
    uid: json['uid'] as String,
    email: json['email'] as String,
    nick: json['nick'] as String,
    skins: (json['skins'] as List)
        ?.map((e) =>
            e == null ? null : SkinModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PlayerModelToJson(PlayerModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'nick': instance.nick,
      'skins': instance.skins,
    };
