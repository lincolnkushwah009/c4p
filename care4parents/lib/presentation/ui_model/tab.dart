import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewTab {
  final int index;
  final String title;
  final String icon;

  const NewTab({
    @required this.index,
    @required this.title,
    this.icon,
  })  : assert(index >= 0, 'index cannot be negative'),
        assert(title != null, 'title cannot be null');
}
