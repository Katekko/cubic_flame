// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) {
  return StoreModel(
    skins: (json['skins'] as List)
        ?.map((e) =>
            e == null ? null : SkinModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      'skins': instance.skins,
    };
