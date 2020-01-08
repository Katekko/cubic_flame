import 'package:cubic_flame/core/models/interfaces/purchasable.interface.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'skin.model.g.dart';

@JsonSerializable()
class SkinModel extends Purchasable {
  int id;
  String name;
  String img;
  bool actived;

  SkinModel({
    @required this.id,
    @required this.img,
    @required this.name,
    @required double price,
    @required bool canBuy,
  }) : super(price: price, canBuy: canBuy);

  factory SkinModel.fromJson(Map<String, dynamic> json) =>
      _$SkinModelFromJson(json);

  Map<String, dynamic> toJson() => _$SkinModelToJson(this);
}
