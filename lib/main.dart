import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'common/utils/sql.util.dart';
import 'infra/navigation/routes.dart';
import 'infra/navigation/routes_delegates.dart';

class NavigationLib extends StatelessWidget with RoutesDelegates {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.initialRoute,
      onGenerateRoute: routeTo,
      onUnknownRoute: unknownRoute,
      theme: ThemeData(fontFamily: 'GameFont'),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqlUtil.createDatabaseModel();
  final dio = Dio();
  dio.options.connectTimeout = 25;
  dio.options.headers['Content-Type'] = 'application/json';
  GetIt.I.registerSingleton(Dio());

  return runApp(NavigationLib());
}
