import 'package:flutter/material.dart';

class StoreButtonWidget extends StatelessWidget {
  const StoreButtonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => Navigator.of(context).pushNamed('/store'),
      color: Colors.deepOrangeAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontFamily: 'GameFont',
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'STORE\n',
            ),
            TextSpan(
              text: 'comming soon',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black.withOpacity(.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
