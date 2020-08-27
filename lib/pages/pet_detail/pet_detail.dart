import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petplanet/models/api/post.dart';
import 'dart:convert';
import 'dart:typed_data';

class PetDetail extends StatefulWidget {
  const PetDetail(
    this.post, {
      Key key,
    }) : super(key: key);

  final Post post;

  @override
  _PetDetailState createState() => _PetDetailState(this.post);
}

class _PetDetailState extends State {

  _PetDetailState(this.post);

  Post post;

  Widget _buildBody() {
    print(post.images);
    var image;
    if(this.post.image == null){
      image = Image(
        image: AssetImage('assets/exmaple/pet_images/0-0.jpg'),
      );
    }else{
      Uint8List bytes = base64.decode(this.post.image);
      image = new Image.memory(bytes);
    }

    return SafeArea(
      child: Column(
        children: <Widget>[
          Text(post.title),
          Text(post.content),
          image,
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }
}