import 'package:flutter/material.dart';
import 'package:petplanet/model/app_state_model.dart';
import 'package:petplanet/pages/home/home.dart';
import 'package:petplanet/pages/login.dart';
import 'package:scoped_model/scoped_model.dart';

class App extends StatefulWidget {
  const App({
    Key key,
  }) : super(key: key);

  static const String homeRoute = '/';
  static const String loginRoute = '/login';

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: App.loginRoute,
      onGenerateInitialRoutes: (_) {
        return [
          MaterialPageRoute<void>(
            builder: (context) => const LoginPage(),
          ),
        ];
      },
      routes: {
        App.loginRoute: (context) => const LoginPage(),
        App.homeRoute: (context) => const HomePage(),
      },
    );
  }
}