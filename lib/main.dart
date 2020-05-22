import 'package:flutter/material.dart';
import 'package:petplanet/routes.dart';

void main() {
  runApp(PetPlanetApp());
}

class PetPlanetApp extends StatelessWidget {
  const PetPlanetApp({
    Key key,
    this.initialRoute,
    this.isTestMode = false,
  }) : super(key: key);

  final bool isTestMode;
  final String initialRoute;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  Builder(
      builder: (context){
        return MaterialApp(
          title: 'Pet Planet',
          theme: ThemeData(
            // primarySwatch: Colors.white,
          ),
          initialRoute: initialRoute,
          onGenerateRoute: RouteConfiguration.onGenerateRoute,
        );
      }
    );
  }
}
