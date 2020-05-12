import 'package:flutter/material.dart';
import 'package:petplanet/data/exmaple/pet.dart';
import 'package:petplanet/pages/home/pet_card.dart';

const _listViewPadding = 8.0;

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var petList = <Widget>[];
    for (var pet in exmaplePetList){
      petList.add(
        Padding(
          padding: const EdgeInsets.all(
            _listViewPadding,
          ),
          child: PetCard()
        )
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Flutter'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(
            _listViewPadding,
          ),
          children: petList,
        )
      ),
    );
  }
}