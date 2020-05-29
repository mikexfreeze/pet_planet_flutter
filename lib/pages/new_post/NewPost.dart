import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {

  // My IPv4 : 192.168.43.171
  final String phpEndPoint = 'http://192.168.43.171/phpAPI/image.php';
  final String nodeEndPoint = 'http://192.168.43.171:3000/image';
  File file;

  void _showPhotoSourceModal() async {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return PhotoSourceSelector();
      },
    );
//    file = await ImagePicker.pickImage(source: ImageSource.camera);
//    file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }



  void _upload() {
    if (file == null) return;
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;
    print('upload');
    http.post(phpEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
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
                    onPressed: _showPhotoSourceModal,
                    child: Text('上传照片'),
                  ),
                  SizedBox(width: 10.0),
                  RaisedButton(
                    onPressed: _upload,
                    child: Text('Upload Image'),
                  )
                ],
              ),
              file == null
                ? Text('No Image Selected')
                : Image.file(file)
            ],
          ),
        ),
      )
    );
  }
}

class PhotoSourceSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Container(
            height: 70,
            child: Center(
              child: Text(
                '选择图片来源',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Divider(thickness: 1),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.lightBlue,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.insert_photo),
                      color: Colors.white,
                      onPressed: () {

                      },
                    ),
                  ),
                  Text('图库选择')
                ],
              ),
              _PhotoShapeIcon(icon: Icons.photo_camera, title: '拍照上传')
            ],
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
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Ink(
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(icon),
            color: Colors.white,
            onPressed: () {

            },
          ),
        ),
        Text(title)
      ],
    );
  }
}

