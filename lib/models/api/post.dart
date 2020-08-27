
import 'package:flutter/material.dart';

class Post {
  final String title;

  final String content;

  final String image;

  final List images;

  Post({
    @required this.title,
    @required this.content,
    this.image,
    this.images
  });

  Post.loading() : this(title: '...', content: '...');

  bool get isLoading => title == '...';
}
