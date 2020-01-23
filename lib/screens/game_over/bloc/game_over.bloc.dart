import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'game_over.bloc.g.dart';

class GameOverBloc = _GameOverBloc with _$GameOverBloc;

abstract class _GameOverBloc with Store {
  final DomainAuthService domainAuthService;
  final usuarioController = TextEditingController();
  final senhaController = TextEditingController();

  _GameOverBloc({@required this.domainAuthService});

  Future<bool> sendScore({
    @required String usuario,
    @required String senha,
    bool autenticacaoOnline = true,
  }) async {
    try {
      var result = await domainAuthService.autenticarLogin(
        autenticacaoOnline: autenticacaoOnline,
        senha: senha,
        usuario: usuario,
      );
      return result;
    } catch (err) {
      rethrow;
    }
  }
}
