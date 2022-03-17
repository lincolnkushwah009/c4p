import 'package:care4parents/data/models/vital_type_result.dart';
import 'package:care4parents/values/values.dart';

class Constants {
  static String switchName(type) {
    String name;
    switch (type) {
      case 'bp':
        name = StringConst.label.Blood_Pressure;

        break;

      case 'sugar':
        name = StringConst.label.Blood_Sugar;

        break;

      case 'spo2':
        name = StringConst.label.SPO2;

        break;
      case 'ecg':
        name = StringConst.label.ECG;
        break;
      // default:
      //   name = StringConst.label.Blood_Pressure;
    }
    return name;
  }

   static String switchRecordTitle(type) {
    String name;
    switch (type) {
      case 'Blood Pressure':
        name ='bp';

        break;

      case 'Blood Sugar':
        name = 'sugar';

        break;

      case 'SPO2':
        name = 'spo2';

        break;
      case 'ECG':
        name = 'ecg';
        break;
      // default:
      //   name = StringConst.label.Blood_Pressure;
    }
    return name;
  }

  static String switchNameByIndex(int index) {
    String name;
    switch (index) {
      case 0:
        name = StringConst.label.Blood_Pressure;

        break;

      case 1:
        name = StringConst.label.Blood_Sugar;

        break;

      case 2:
        name = StringConst.label.SPO2;

        break;
      case 3:
        name = StringConst.label.ECG;
        break;
      default:
        name = StringConst.label.Blood_Pressure;
    }
    return name;
  }

  static String switchTypeByIndex(int index) {
    String name;
    switch (index) {
      case 0:
        name = 'bp';

        break;

      case 1:
        name = 'sugar';

        break;

      case 2:
        name = 'spo2';

        break;
      case 3:
        name = 'ecg';
        break;
      default:
    }
    return name;
  }

  static List<String> generateHeader(VitalTypeResult type_item) {
    List<String> headers = [];
    String name;
    switch (type_item.type) {
      case 'bp':
        name = StringConst.label.Systolic;

        break;

      case 'sugar':
        name = StringConst.label.SugarLevel;

        break;

      case 'spo2':
        name = StringConst.label.SPO2;

        break;
      case 'ecg':
        name = StringConst.label.ECG_Report;

        break;

      default:
        name = StringConst.label.Blood_Pressure;
    }
    headers.add('Date');
    headers.add('Time');
    headers.add(name);
    if (type_item.value != null && type_item.value.contains(',')) {
      headers.add(StringConst.label.Diastrolic);
    }
    return headers;
  }
}
