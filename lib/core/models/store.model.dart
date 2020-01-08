import 'package:flutter/foundation.dart';

import 'skin.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store.model.g.dart';

@JsonSerializable()
class StoreModel {
  List<SkinModel> skins;
  StoreModel({@required this.skins});

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}
