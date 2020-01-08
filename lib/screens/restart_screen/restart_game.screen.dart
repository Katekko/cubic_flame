import 'package:cubic_flame/core/blocs/level_1.bloc.dart';
import 'package:cubic_flame/core/blocs/rank.bloc.dart';
import 'package:cubic_flame/core/models/enviar_score.model.dart';
import 'package:cubic_flame/core/models/player.model.dart';
import 'package:cubic_flame/screens/restart_screen/best_score.widget.dart';
import 'package:cubic_flame/screens/restart_screen/info_match.widget.dart';
import 'package:cubic_flame/screens/restart_screen/login_button.widget.dart';
import 'package:cubic_flame/screens/restart_screen/menu_button.widget.dart';
import 'package:cubic_flame/screens/restart_screen/player_again_button.widget.dart';
import 'package:cubic_flame/screens/restart_screen/send_score_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RestartGameScreen extends StatefulWidget {
  final Level1Bloc levelBloc;
  final RankBloc rankBloc;
  final bool turbo;
  RestartGameScreen({
    @required this.levelBloc,
    @required this.rankBloc,
    @required this.turbo,
  });

  @override
  _RestartGameScreenState createState() => _RestartGameScreenState();
}

class _RestartGameScreenState extends State<RestartGameScreen> {
  GlobalKey<ScaffoldState> _scaffolKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffolKey,
        body: Container(
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: Text(
                        'To submit your score to leaderboard, please do the login first!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 55),
                    BestScoreWidget(bestScore: widget.levelBloc.bestScore),
                    SizedBox(height: 10),
                    _BuildLoginSendScoreWidget(
                      levelBloc: widget.levelBloc,
                      rankBloc: widget.rankBloc,
                    ),
                    SizedBox(height: 50),
                    InfoMatchWidget(score: widget.levelBloc.playerScore),
                    SizedBox(height: 30),
                    PlayAgainButtonWidget(
                      bloc: widget.levelBloc,
                      turbo: widget.turbo,
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      onPressed: () => Navigator.of(context).pushNamed('/rank'),
                      color: Colors.yellowAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        'LEADERBOARD',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    SizedBox(height: 10),
                    MenuButtonWidget(bloc: widget.levelBloc),
                  ],
                ),
              ),
              _LoadingWidget(bloc: widget.rankBloc)
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  final RankBloc bloc;
  const _LoadingWidget({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloc.loadingStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ModalBarrier(
                color: Colors.grey.withOpacity(.2),
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.purpleAccent,
              )
            ],
          );
        }
        return Center();
      },
    );
  }
}

class _BuildLoginSendScoreWidget extends StatelessWidget {
  final Level1Bloc levelBloc;
  final RankBloc rankBloc;
  const _BuildLoginSendScoreWidget({
    @required this.levelBloc,
    @required this.rankBloc,
  });

  @override
  Widget build(BuildContext context) {
    rankBloc.checkPlayerLogged();
    return StreamBuilder<PlayerModel>(
      stream: rankBloc.playerStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoginButtonWidget(bloc: rankBloc);
        }
        PlayerModel player = snapshot.data;
        EnviarScoreModel enviarScoreModel = EnviarScoreModel(
          uid: player.uid,
          email: player.email,
          nick: player.nick,
          score: levelBloc.bestScore,
          hashScore: levelBloc.hashScore,
          skins: player.skins,
        );
        return SendScoreButtonWidget(
          bloc: rankBloc,
          enviarScoreModel: enviarScoreModel,
        );
      },
    );
  }
}
