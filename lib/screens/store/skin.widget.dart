import 'package:cubic_flame/core/models/skin.model.dart';
import 'package:flutter/material.dart';

class SkinWidget extends StatelessWidget {
  final SkinModel skin;
  const SkinWidget({@required this.skin});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * .3,
        width: MediaQuery.of(context).size.width * .6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 3),
            Text(
              skin.name,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Image.asset(
              'resources/earth-skin.jpg',
              height: MediaQuery.of(context).size.height * .1,
              width: MediaQuery.of(context).size.width * .3,
            ),
            Text(
              'g ' + skin.price.toStringAsFixed(2),
              style: TextStyle(color: Colors.redAccent),
            ),
            RaisedButton(
              onPressed: () => {},
              color: Colors.deepOrangeAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text('Purchase'),
            ),
            SizedBox(height: 3),
          ],
        ),
      ),
    );
  }
}
