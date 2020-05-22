import 'package:flutter/material.dart';
import 'package:petplanet/models/user.dart';
import 'package:petplanet/pages/home/home.dart';
import 'package:petplanet/pages/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => UserModel()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}

_initDataFromDisk() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
  print('Pressed $counter times.');
  await prefs.setInt('counter', counter);
}