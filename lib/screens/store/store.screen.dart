import 'package:cubic_flame/core/models/player.model.dart';
import 'package:cubic_flame/core/models/skin.model.dart';
import 'package:cubic_flame/core/models/store.model.dart';
import 'package:cubic_flame/core/services/player.service.dart';
import 'package:cubic_flame/screens/store/skin.widget.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  PageController _pageController;
  PlayerService _playerService;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _playerService = PlayerService();
  }

  Future<StoreModel> getStore() async {
    List<SkinModel> skins = List<SkinModel>();
    skins.addAll([
      SkinModel(id: 1, name: 'Flat Earth', img: 'asd', price: 2, canBuy: true),
      SkinModel(id: 2, name: 'Flat Earth', img: 'asd', price: 2, canBuy: true),
      SkinModel(id: 3, name: 'Flat Earth', img: 'asd', price: 2, canBuy: true),
      SkinModel(id: 4, name: 'Flat Earth', img: 'asd', price: 2, canBuy: true),
      SkinModel(id: 5, name: 'Flat Earth', img: 'asd', price: 2, canBuy: true),
      SkinModel(id: 6, name: 'Flat Earth', img: 'asd', price: 2, canBuy: true),
    ]);

    StoreModel store = StoreModel(skins: skins);

    return store;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'STORE',
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<PlayerModel>(
        future: null,
        builder: (context, snapshot) {
          return Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'g 9999,99',
                    style: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              FutureBuilder<StoreModel>(
                future: getStore(),
                builder: (context, AsyncSnapshot<StoreModel> snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: PageView(
                        controller: _pageController,
                        children: snapshot.data.skins.map((skin) {
                          return SkinWidget(skin: skin);
                        }).toList(),
                      ),
                    );
                  }
                  return Center();
                },
              ),
            ],
          );
        }
      ),
    );
  }
}
