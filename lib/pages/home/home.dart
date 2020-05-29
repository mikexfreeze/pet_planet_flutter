import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/new-post'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: _listViewPadding,
          ),
          itemCount: 2,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: _listViewPadding,
              ),
              child: PetCard()
            );
          }
        )
      ),
    );
  }
}