import 'package:flutter/material.dart';

import 'core/libs/navigation.dart';

void main() async {
  runApp(
    MaterialApp(
      initialRoute: '/',
      theme: ThemeData(fontFamily: 'GameFont'),
      onGenerateRoute: NavigationLib.generateRoutes,
    ),
  );
}
