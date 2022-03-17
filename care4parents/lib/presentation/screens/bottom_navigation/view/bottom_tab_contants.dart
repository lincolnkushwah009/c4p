import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:care4parents/presentation/ui_model/tab.dart';

class BottomTabConstants {
  static const List<NewTab> bottomTabs = const [
    const NewTab(
        index: 0,
        title: StringConst.APPOINTMENT,
        icon: ImagePath.APPOINTMENT_ICON),
    const NewTab(
        index: 1, title: StringConst.REPORTS, icon: ImagePath.REPORT_ICON),
    // const NewTab(
    //     index: 2,
    //     title: StringConst.UPLOAD_REPORT,
    //     icon: ImagePath.REPORT_ICON),
  ];
}
