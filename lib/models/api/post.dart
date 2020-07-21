
import 'package:flutter/material.dart';

class Post {
  final String title;

  final String content;

  Post({
    @required this.title,
    @required this.content,
  });

  Post.loading() : this(title: '...', content: '...');

  bool get isLoading => title == '...';
}
