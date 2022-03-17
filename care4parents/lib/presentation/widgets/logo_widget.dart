import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key key,
    @required this.widthOfScreen,
  }) : super(key: key);

  final double widthOfScreen;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImagePath.LOGO,
      width: widthOfScreen * 0.6,
      fit: BoxFit.cover,
    );
  }
}
