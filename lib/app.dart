import 'package:flutter/material.dart';
import 'package:petplanet/models/user.dart';
import 'package:petplanet/pages/home/home.dart';
import 'package:petplanet/pages/login.dart';
import 'package:petplanet/pages/new_post/NewPost.dart';

class App extends StatefulWidget {
  const App({
    Key key,
  }) : super(key: key);

  static const String homeRoute = '/';
  static const String loginRoute = '/login';
  static const String newPostRoute = '/new-post';

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  String token;
  UserModel user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
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
        App.newPostRoute: (context) => NewPost(),
      },
    );
  }
}