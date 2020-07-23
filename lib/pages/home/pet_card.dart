import 'package:flutter/material.dart';
import 'package:petplanet/models/api/post.dart';
import 'package:petplanet/pages/pet_detail/pet_detail.dart';
import 'dart:typed_data';
import 'dart:convert';

class PetCard extends StatelessWidget {

  const PetCard(
    this.post, {
      Key key,
    }) : super(key: key);

  final Post post;

  @override
  Widget build(context) {
    var image;
    if(this.post.image == null){
      image = Image(
        image: AssetImage('assets/exmaple/pet_images/0-0.jpg'),
      );
    }else{
      Uint8List bytes = base64.decode(this.post.image);
      image = new Image.memory(bytes);
    }

    final imageWidget = AspectRatio(
      aspectRatio: 3/2,
      child: FittedBox(
        fit: BoxFit.cover,
        child: image
      )
    );

    return InkWell(
      onTap: () => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => PetDetail(
//            id: index,
//            song: songNames[index],
//            color: color,
          ),
        ),
      ),
      child: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              imageWidget,
              ListTile(

                title: Text(
                  this.post.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(this.post.content),
//                trailing: IconButton(
//                  icon: Icon(Icons.more_horiz),
//                  color: Colors.black,
//                  onPressed: () => print('More'),
//                ),
              ),
            ]
        ),
      ),
    );
  }
}