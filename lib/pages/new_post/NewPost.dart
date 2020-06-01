import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker/multi_image_picker.dart';

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
        return PhotoSourceSelector(
          hdlSelectImages: _hdlSelectImages
        );
      },
    );
//    file = await ImagePicker.pickImage(source: ImageSource.camera);
//    file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  void _hdlSelectImages () async {
    var resultList = await MultiImagePicker.pickImages(
      maxImages :  10 ,
      enableCamera: true,
    );

    // The data selected here comes back in the list
    print('resultList $resultList');
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
                    onPressed: _hdlSelectImages,
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

