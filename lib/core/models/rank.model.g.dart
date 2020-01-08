// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankModel _$RankModelFromJson(Map<String, dynamic> json) {
  return RankModel(
    uid: json['uid'],
    email: json['email'],
    nick: json['nick'],
    skins: json['skins'],
    score: json['score'] as int,
  );
}

Map<String, dynamic> _$RankModelToJson(RankModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'nick': instance.nick,
      'skins': instance.skins,
      'score': instance.score,
    };
