import 'package:flutter/material.dart';

class PetCard extends StatelessWidget {
  @override
  Widget build(context) {
    final imageWidget = AspectRatio(
      aspectRatio: 3/2,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image(
          image: AssetImage('assets/exmaple/pet_images/0-0.jpg'),
        ),
      )
    );

    return Container(
      color: Colors.black38,
      child: Column(
        children: [
          imageWidget

        ]
      ),
    );
  }
}