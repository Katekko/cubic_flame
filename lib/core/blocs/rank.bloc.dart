import 'package:cubic_flame/core/models/enviar_score.model.dart';
import 'package:cubic_flame/core/models/player.model.dart';
import 'package:cubic_flame/core/models/rank.model.dart';
import 'package:cubic_flame/core/services/auth.service.dart';
import 'package:cubic_flame/core/services/player.service.dart';
import 'package:cubic_flame/core/services/rank.service.dart';
import 'package:cubic_flame/screens/restart_screen/choose_name.modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RankBloc {
  PlayerService _playerService = PlayerService();
  AuthService _authService = AuthService();
  PackageInfo _packageInfo;

  final _rankController = BehaviorSubject<List<RankModel>>();
  Observable<List<RankModel>> get rankStream => _rankController.stream;

  final _playerController = PublishSubject<PlayerModel>();
  Observable<PlayerModel> get playerStream => _playerController.stream;

  final _loadingController = BehaviorSubject<bool>();
  Observable<bool> get loadingStream => _loadingController.stream;

  void getRank() async {
    try {
      RankService rankService = RankService();
      var rank = await rankService.getRank();

      _rankController.add(rank);
    } catch (err) {
      _rankController.addError(err);
    }
  }

  Future<bool> sendScore({@required EnviarScoreModel model}) async {
    try {
      _loadingController.add(true);
      _packageInfo = await PackageInfo.fromPlatform();
      model.versaoApp = _packageInfo.version;
      RankService rankService = RankService();
      var sucesso = await rankService.enviarScore(model: model);
      return Future.value(sucesso);
    } catch (err) {
      rethrow;
    } finally {
      _loadingController.add(false);
    }
  }

  Future<bool> checkNickExist({@required String nick}) async {
    try {
      var exist = await _playerService.checkNickExists(nick: nick);
      return Future.value(exist);
    } catch (err) {
      rethrow;
    }
  }

  Future<dynamic> checkPlayerLogged() async {
    var prefs = await SharedPreferences.getInstance();
    bool estaLogado = prefs.containsKey('uid');
    if (estaLogado) {
      PlayerModel player = PlayerModel(
        uid: prefs.getString('uid'),
        email: null,
        nick: null,
        skins: null,
      );
      _playerController.add(player);
    }
  }

  Future<dynamic> logarUsuario({@required BuildContext context}) async {
    try {
      _loadingController.add(true);
      var prefs = await SharedPreferences.getInstance();
      bool estaLogado = prefs.containsKey('uid');
      if (estaLogado) {
        String uid = prefs.getString('uid');
        PlayerModel player = await _playerService.getPlayer(uid: uid);
        _playerController.add(player);
      } else {
        FirebaseUser user = await _authService.handleSignInGoogle();
        PlayerModel player = await _playerService.getPlayer(uid: user.uid);
        if (player.uid == null) {
          String nick = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => ChooseNameModal(rankBloc: this),
          );
          if (nick != null && nick.isNotEmpty) {
            player = PlayerModel(uid: user.uid, email: user.email, nick: nick);
            await _playerService.postCriarPlayer(player: player);
            _playerController.add(player);
            prefs.setString('uid', player.uid);
          } else {
            _playerController.addError('NOME VAZIO');
          }
        } else {
          _playerController.add(player);
          prefs.setString('uid', player.uid);
        }
      }
    } catch (err) {
      rethrow;
    } finally {
      _loadingController.add(false);
    }
  }

  void dispose() {
    _rankController.close();
    _playerController.close();
    _loadingController.close();
  }
}
