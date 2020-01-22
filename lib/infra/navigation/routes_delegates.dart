import 'package:cubic_flame/game/levels/normal/normal.bloc.dart';
import 'package:cubic_flame/game/levels/normal/normal.state.dart';
import 'package:cubic_flame/game/levels/turbo/turbo.bloc.dart';
import 'package:cubic_flame/game/levels/turbo/turbo.state.dart';
import 'package:cubic_flame/screens/menu/menu.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes.dart';

final _routes = {
  Routes.MENU: _menu,
  Routes.NORMAL_GAME: _normalGame,
  Routes.TURBO_GAME: _turboGame,
};

Route _menu(Object object) {
  return _SlideToLeftRoute(
    page: MenuScreen(),
  );
}

Route _normalGame(Object object) {
  return _SlideToLeftRoute(
    page: Provider(
      create: (_) => NormalGameBloc(),
      child: NormalGameState(),
    ),
  );
}

Route _turboGame(Object object) {
  return _SlideToLeftRoute(
    page: Provider(
      create: (_) => TurboGameBloc(),
      child: TurboGameState(),
    ),
  );
}

mixin RoutesDelegates {
  Route routeTo(RouteSettings route) {
    final routeWidget = _routes[route.name];
    return routeWidget(route.arguments);
  }

  Route unknownRoute(RouteSettings route) {
    return _SlideToLeftRoute(
      page: UnknowRoute(),
    );
  }
}

class _SlideToLeftRoute extends PageRouteBuilder {
  final Widget page;
  _SlideToLeftRoute({@required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return page;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}

class UnknowRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Unknow Route'),
    );
  }
}
