// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petplanet/utils/fetch.dart';
import 'dart:convert' as convert;

import 'post.dart';
import 'page.dart';

var catalogLength = 200;

/// This function emulates a REST API call. You can imagine replacing its
/// contents with an actual network call, keeping the signature the same.
///
/// It will fetch a page of items from [startingIndex].
Future<ItemPage> fetchPage(int startingIndex, int pageIndex) async {
  var hasNext = true;
  var listLength = 0;
  var client = Fetch();
  final response = await client.get('api/posts?page=${pageIndex}&size=$itemsPerPage');
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    print('api/posts: ${jsonResponse}');
    listLength = jsonResponse.length;
    if(listLength > 0){
      if(listLength < itemsPerPage){
        // 如果此时列表长度小于每页长度则已经到达最后一页
        catalogLength = startingIndex + listLength;
        hasNext = false;
      }
//      print('jsonResponse.length ${jsonResponse.length}');
    }
//    var itemCount = jsonResponse['totalItems'];
//    print('Number of books about http: $itemCount.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }

  // If the [startingIndex] is beyond the bounds of the catalog, an
  // empty page will be returned.
  if (startingIndex > catalogLength) {
    return ItemPage(
      post: [],
      startingIndex: startingIndex,
      hasNext: false,
    );
  }

  // The page of items is generated here.
  return ItemPage(
    post: List.generate(
      hasNext ? itemsPerPage : listLength,
      (index) => Post(
        title: '1',
        content: 'content',
      )),
    startingIndex: startingIndex,
    // Returns `false` if we've reached the [catalogLength].
    hasNext: startingIndex + itemsPerPage < catalogLength,
  );
}
