import 'package:cubic_flame/infra/navigation/routes.dart';
import 'package:flutter/material.dart';

class TurboGameButtonWidget extends StatelessWidget {
  const TurboGameButtonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () =>
          Navigator.of(context).pushReplacementNamed(Routes.TURBO_GAME),
      color: Colors.redAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text('TURBO GAME'),
    );
  }
}
