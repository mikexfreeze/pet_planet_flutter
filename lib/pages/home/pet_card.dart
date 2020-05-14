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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          imageWidget,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[

                  new SizedBox(
                    height: 30,
                    width: 10.0,
                  ),
                  new Text(
                    "金毛求收养",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ]
      ),
    );
  }
}