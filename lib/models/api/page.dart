// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'post.dart';

const int itemsPerPage = 20;

class ItemPage {
  final List<Post> post;

  final int startingIndex;

  final bool hasNext;

  ItemPage({
    @required this.post,
    @required this.startingIndex,
    @required this.hasNext,
  });
}
