import 'package:cubic_flame/core/blocs/level_1.bloc.dart';
import 'package:flutter/material.dart';

class MenuButtonWidget extends StatelessWidget {
  final Level1Bloc bloc;
  const MenuButtonWidget({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        bloc.resetPlayer();
        Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
      },
      color: Colors.purpleAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        height: 30,
        child: Center(
          child: Text(
            'MENU',
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}
