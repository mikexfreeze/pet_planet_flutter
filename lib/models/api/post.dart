
import 'package:flutter/material.dart';

class Post {
  final String title;

  final String content;

  final String image;



  Post({
    @required this.title,
    @required this.content,
    this.image
  });

  Post.loading() : this(title: '...', content: '...');

  bool get isLoading => title == '...';
}
