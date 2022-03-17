// import 'package:flutter/material.dart';

// class ArrowClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(0, size.height);
//     path.lineTo(size.width / 2, size.height / 2);
//     path.lineTo(size.width, size.height);
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';

class ArrowShape extends ShapeBorder {
  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getOuterPath
    return getClip(rect.size);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    throw UnimplementedError();
  }

  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

// String switchName(type) {
//   String name;
//   switch (type) {
//     case 'bp':
//       name = StringConst.label.Blood_Pressure;

//       break;

//     case 'sugar':
//       name = StringConst.label.Blood_Sugar;

//       break;

//     case 'spo2':
//       name = StringConst.label.SPO2;

//       break;
//     case 'ecg':
//       name = StringConst.label.ECG;
//       break;
//     default:
//       name = StringConst.label.Blood_Pressure;
//   }
//   return name;
// }
