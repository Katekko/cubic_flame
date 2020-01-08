import 'package:cubic_flame/core/blocs/rank.bloc.dart';
import 'package:cubic_flame/core/models/rank.model.dart';
import 'package:flutter/material.dart';

class RankScreen extends StatelessWidget {
  final RankBloc bloc;
  RankScreen({@required this.bloc}) {
    bloc.getRank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LEADERBOARD',
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: StreamBuilder<List<RankModel>>(
          stream: bloc.rankStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    dynamic color = Colors.grey;
                    if (index + 1 == 1) color = Colors.yellowAccent;
                    if (index + 1 == 2) color = Colors.lightGreenAccent;
                    if (index + 1 == 3) color = Colors.brown;

                    dynamic colorContainer = Colors.grey[600];
                    if ((index + 1) % 2 == 0) colorContainer = Colors.grey[700];

                    return Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Container(
                        decoration: BoxDecoration(color: colorContainer),
                        child: Padding(
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                (index + 1).toString(),
                                style: TextStyle(fontSize: 22, color: color),
                              ),
                              Text(
                                ' - ',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                snapshot.data[index].nick,
                                style:
                                    TextStyle(fontSize: 22, color: Colors.white),
                              ),
                              Text(
                                ' - ',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                snapshot.data[index].score.toString(),
                                style:
                                    TextStyle(fontSize: 22, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Center();
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
