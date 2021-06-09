// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';



class CustomPreferredSize extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a widget that has a preferred size that the parent can query.
   CustomPreferredSize({
    Key key,
    this.child,
    this.preferredSize,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) => child;

}
