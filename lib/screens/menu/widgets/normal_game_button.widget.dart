import 'package:cubic_flame/infra/navigation/routes.dart';
import 'package:flutter/material.dart';

class NormalGameButtonWidget extends StatelessWidget {
  const NormalGameButtonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(Routes.NORMAL_GAME);
      },
      color: Colors.greenAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text('NORMAL GAME'),
    );
  }
}
