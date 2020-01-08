// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enviar_score.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnviarScoreModel _$EnviarScoreModelFromJson(Map<String, dynamic> json) {
  return EnviarScoreModel(
    uid: json['uid'],
    email: json['email'],
    nick: json['nick'],
    score: json['score'],
    hashScore: json['hashScore'] as String,
    skins: json['skins'],
    versaoApp: json['versaoApp'] as String,
  );
}

Map<String, dynamic> _$EnviarScoreModelToJson(EnviarScoreModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'nick': instance.nick,
      'skins': instance.skins,
      'score': instance.score,
      'hashScore': instance.hashScore,
      'versaoApp': instance.versaoApp,
    };
