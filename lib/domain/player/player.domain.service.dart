import 'package:cubic_flame/domain/player/models/player.model.dart';
import 'package:cubic_flame/domain/player/repository/player.repository.dart';
import 'package:flutter/foundation.dart';

class DomainPlayerService {
  PlayerRepository playerRepository;

  DomainPlayerService({@required this.playerRepository});

  Future<DomainPlayerModel> getPlayer({@required String uid}) async {
    DomainPlayerModel player = await playerRepository.getPlayer(uid: uid);
    if (player == null) {
    } else {
      return player;
    }
  }
}
