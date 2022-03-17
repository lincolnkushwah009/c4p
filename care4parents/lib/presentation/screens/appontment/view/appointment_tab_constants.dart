import 'package:care4parents/presentation/ui_model/tab.dart';
import 'package:care4parents/values/values.dart';

class AppointmentTabConstants {
  static const List<NewTab> appointmentTabs = const [
    const NewTab(index: 1, title: StringConst.REQUESTED_TAB),
    const NewTab(index: 0, title: StringConst.UPCOMING_TAB),
    const NewTab(index: 2, title: StringConst.PAST_TAB),
  ];
}
