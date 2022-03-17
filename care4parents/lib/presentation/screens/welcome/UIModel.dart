import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UIData{
  final String text;
      final IconData backgroundicon;
  final Color color;

  UIData({ this.text,  this.backgroundicon,  this.color});
  static List<UIData> sampleData = [
    UIData(text: "Purchase Plan", backgroundicon: FontAwesomeIcons.gift, color: Color(0xFFAEDF48)),
    UIData(text: "SOS *", backgroundicon:FontAwesomeIcons.bell, color: Color(0xFFEE4948)),
    UIData(text: "Book Service", backgroundicon: FontAwesomeIcons.userMd, color: Color(0xFFF9A936)),
    UIData(text: "Book Appointment", backgroundicon:FontAwesomeIcons.stethoscope, color: Color(0xFFF5744D)),
    UIData(text: "Dashboard", backgroundicon: FontAwesomeIcons.heart, color: Color(0xFF5EC0F3)),
    UIData(text: "Add CareCash", backgroundicon:FontAwesomeIcons.moneyBillAlt, color: Color(0xFF5A51FF)),
    UIData(text: "Report", backgroundicon: FontAwesomeIcons.fileAlt, color: Color(0xFFAEDF48)),

  ];
}


// UIData(text: "Book Service", backgroundicon: "assets/images/pulse-rate.png", color: Color(0xFFF9A936)),
// UIData(text: "Doctor's Appointment", backgroundicon: "assets/images/note.png", color: Color(0xFFF5744D)),
//
