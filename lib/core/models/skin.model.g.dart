// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skin.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkinModel _$SkinModelFromJson(Map<String, dynamic> json) {
  return SkinModel(
    id: json['id'] as int,
    img: json['img'] as String,
    name: json['name'] as String,
    price: (json['price'] as num)?.toDouble(),
    canBuy: json['canBuy'] as bool,
  )..actived = json['actived'] as bool;
}

Map<String, dynamic> _$SkinModelToJson(SkinModel instance) => <String, dynamic>{
      'price': instance.price,
      'canBuy': instance.canBuy,
      'id': instance.id,
      'name': instance.name,
      'img': instance.img,
      'actived': instance.actived,
    };
