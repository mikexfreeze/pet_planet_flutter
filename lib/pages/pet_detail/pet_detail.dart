import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PetDetail extends StatefulWidget {
  @override
  _PetDetailState createState() => _PetDetailState();
}

class _PetDetailState extends State {

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Text('某某小区，三个月大的金茂xxx,求收养xxxx,联系方式： 微信 xxxxxxxx'),
          Image(
            image: AssetImage('assets/exmaple/pet_images/0-0.jpg'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('金毛')),
      body: _buildBody(),
    );
  }
}