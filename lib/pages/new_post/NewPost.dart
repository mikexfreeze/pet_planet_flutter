import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:petplanet/models/user.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {

  List<Asset> images = List<Asset>();
  UserModel user;
  String _error;
  File file;
  List<int> imageIds;

  Future<void> _hdlSelectImages() async {
    setState(() {
      images = List<Asset>();
    });
    imageIds = [];

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    for (Asset asset in resultList) {
      ByteData byteData = await asset.getByteData(quality: 20);
      List<int> imageData = byteData.buffer.asUint8List();

      String imageB64 = base64Encode(imageData);
      var res = _upload(imageB64);
      await res.then((value) {
        imageIds.add(value.id);
      }).catchError((error) => print(error));
    }
    print('imageIds $imageIds');
    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  Widget buildGridView() {
    if (images != null)
      return GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    else
      return Container(color: Colors.white);
  }

  Future<ImageId> _upload(imageB64) async {
    String token = user.token;

    final http.Response response = await http.post(
      Uri.parse('$BASE_URL/api/images'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
      body: jsonEncode(<String, String>{
        'image': imageB64,
        'imageContentType': 'image/jpeg',
      }),
    );

    print('response.body, $response.body');
    if (response.statusCode == 201) {
//      print(json.decode(response.body));
      return ImageId.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to upload.');
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              TextFormField(
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: '请输入',
                  labelText: '标题',
                ),
                onSaved: (value) {
//                loginData.username = value;
                },
//                      validator: _validateName,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '请输入，别忘了留下联系方式',
                  labelText: '正文内容',
                ),
                maxLines: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: _hdlSelectImages,
                    child: Text('上传照片'),
                  ),
                ],
              ),
              buildGridView(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Color(0xFF1976D2),
                    textColor: Colors.white,
                    onPressed: _hdlSelectImages,
                    child: Text('提交'),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}

class PhotoSourceSelector extends StatelessWidget {
  PhotoSourceSelector({
    Key key,
    this.hdlSelectImages,
  }) : super(key: key);

  final Function hdlSelectImages;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        children: [
          Container(
            height: 50,
            child: Center(
              child: Text(
                '选择图片来源',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Divider(thickness: 1),
          Container(
            height: 170,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _PhotoShapeIcon(
                  icon: Icons.insert_photo,
                  title: '图库选择',
                  onPressed: hdlSelectImages
                ),
                _PhotoShapeIcon(icon: Icons.photo_camera, title: '拍照上传')
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _PhotoShapeIcon extends StatelessWidget {
  _PhotoShapeIcon({
    Key key,
    this.icon,
    this.title,
    this.onPressed
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Ink(
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(icon),
            color: Colors.white,
            onPressed: onPressed,
          ),
        ),
        Text(title)
      ],
    );
  }
}

class ImageId {
  int id;

  ImageId({this.id});

  factory ImageId.fromJson(Map<String, dynamic> json) {
    return ImageId(
      id: json['id'],
    );
  }
}