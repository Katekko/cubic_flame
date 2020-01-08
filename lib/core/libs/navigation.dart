import 'package:cubic_flame/core/blocs/level_1.bloc.dart';
import 'package:cubic_flame/core/blocs/rank.bloc.dart';
import 'package:cubic_flame/core/models/restart_game.model.dart';
import 'package:cubic_flame/game/levels/game_level_1.dart';
import 'package:cubic_flame/screens/rank/rank.screen.dart';
import 'package:cubic_flame/screens/restart_screen/restart_game.screen.dart';
import 'package:cubic_flame/screens/start_scren/start.screen.dart';
import 'package:cubic_flame/screens/store/store.screen.dart';
import 'package:flutter/material.dart';

enum _RouteErrorType {
  inexistentRout,
  wrongArgumentType,
}

class NavigationLib {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return _ScaleRoute(
          page: StartScreen(),
        );
      case '/game':
        return _ScaleRoute(
          page: Level1Provider(
            bloc: Level1Bloc(),
            rankBloc: RankBloc(),
            child: Level1State(turbo: args),
          ),
        );
      case '/dead-screen':
        RestartGameModel tempArg = args;
        return _SlideToLeftRoute(
          page: RestartGameScreen(
            levelBloc: tempArg.bloc,
            rankBloc: tempArg.rankBloc,
            turbo: tempArg.turbo,
          ),
        );
      case '/rank':
        return _ScaleRoute(
          page: RankScreen(
            bloc: RankBloc(),
          ),
        );
      case '/store':
        return _ScaleRoute(
          page: StoreScreen(),
        );
      default:
        return _errorHandler(
          error: _RouteErrorType.inexistentRout,
          received: settings.name,
        );
    }
  }

  static Route<dynamic> _errorHandler({
    _RouteErrorType error,
    String expectedValue = '!!!Define a expected value!!!',
    dynamic received = '!!!Pass the value received!!!',
  }) {
    MaterialPageRoute _pageErro(
        {@required String title, @required String bodyText}) {
      return MaterialPageRoute(builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Kat Error'),
            backgroundColor: Colors.purple[400],
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Text(
                bodyText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23),
              ),
            ),
          ),
        );
      });
    }

    switch (error) {
      case _RouteErrorType.wrongArgumentType:
        return _pageErro(
          title: 'Argument Error',
          bodyText:
              'Error while passing value to a new router, \n expected $expectedValue \n and received $received',
        );
        break;
      case _RouteErrorType.inexistentRout:
        return _pageErro(
          title: 'Route not found',
          bodyText:
              'This route that you passed doesn\'t exist! \n Route: $received',
        );
        break;
      default:
        return _pageErro(
          title: 'Mysterious Error',
          bodyText: 'Mysterious error while navigating to another screen!',
        );
        break;
    }
  }
}

class _SlideToLeftRoute extends PageRouteBuilder {
  final Widget page;
  _SlideToLeftRoute({this.page})
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

class _ScaleRoute extends PageRouteBuilder {
  final Widget page;
  _ScaleRoute({this.page})
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
            return ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: child,
            );
          },
        );
}
