import 'package:flutter/foundation.dart';

class DomainPlayerModel {
  String uid;
  String email;
  String nick;
  List<dynamic> skins;
  double gold;

  DomainPlayerModel({
    @required this.uid,
    @required this.email,
    @required this.nick,
    @required this.skins,
    @required this.gold,
  });
}
