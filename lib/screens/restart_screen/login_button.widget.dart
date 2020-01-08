import 'package:cubic_flame/core/blocs/rank.bloc.dart';
import 'package:flutter/material.dart';

class LoginButtonWidget extends StatelessWidget {
  final RankBloc bloc;
  LoginButtonWidget({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => bloc.logarUsuario(context: context),
      color: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        height: 30,
        child: Center(
          child: Text(
            'L O G I N',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
