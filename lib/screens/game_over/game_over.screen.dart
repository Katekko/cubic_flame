import 'package:cubic_flame/screens/game_over/widgets/header_text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/best_score.widget.dart';

class GameOverScreen extends StatefulWidget {
  @override
  _GameOverScreen createState() => _GameOverScreen();
}

class _GameOverScreen extends State<GameOverScreen> {
  GlobalKey<ScaffoldState> _scaffolKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // carregar score salvo do cara aqui
  }

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
                      child: HeaderTextWidget(),
                    ),
                    SizedBox(height: 55),

                    // TODO: Devo salvar o melhor score do cara no banco SQLITE, quando vier pra essa tela irá pegar os dados
                    // BestScoreWidget(bestScore: widget.levelBloc.bestScore),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
