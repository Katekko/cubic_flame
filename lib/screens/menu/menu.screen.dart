import 'package:cubic_flame/screens/menu/widgets/leader_board_button.widget.dart';
import 'package:cubic_flame/screens/menu/widgets/normal_game_button.widget.dart';
import 'package:cubic_flame/screens/menu/widgets/store_button.widget.dart';
import 'package:cubic_flame/screens/menu/widgets/turbo_game_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/demo_game.widget.dart';
import 'widgets/header.widget.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GameDemoWidget(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                HeaderWidget(),
                SizedBox(height: 90),
                NormalGameButtonWidget(),
                SizedBox(height: 20),
                TurboGameButtonWidget(),
                SizedBox(height: 20),
                LeaderBoardButtonWidget(),
                SizedBox(height: 20),
                StoreButtonWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
