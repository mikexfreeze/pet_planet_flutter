import 'package:flutter/material.dart';
import 'package:petplanet/models/posts.dart';
import 'package:petplanet/pages/home/pet_card.dart';
import 'package:provider/provider.dart';

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
        child: Selector<Posts, int>(
          selector: (context, catalog) => catalog.itemCount,
          builder: (context, itemCount, child) => ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: _listViewPadding,
            ),
            itemCount: itemCount,
            itemBuilder: (context, i) {
            // Every item of the `ListView` is individually listening
            // to the catalog.
            var postList = Provider.of<Posts>(context);

            // Catalog provides a single synchronous method for getting
            // the current data.
            var post = postList.getByIndex(i);

            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: _listViewPadding,
              ),
              child: PetCard(post));
          }),
      )),
    );
  }
}
