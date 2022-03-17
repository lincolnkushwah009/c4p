import 'dart:async';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:location/location.dart' as loc;

class PermissionHelper {
  static Future allServices() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.phone,
      Permission.contacts,
    ].request();

    //loc.Location location = //new loc.Location();

    // bool _serviceEnabled = //await location.serviceEnabled();
    // print("Location _serviceEnabled: " + _serviceEnabled.toString());
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     print("Location location.serviceEnabled(): " +
    //         _serviceEnabled.toString());
    //     //return;
    //   }
    // }

    // loc.PermissionStatus _permissionGranted = await location.hasPermission();
    // print("Location PermissionStatus: " + _permissionGranted.toString());

    // if (_permissionGranted != loc.PermissionStatus.granted) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != loc.PermissionStatus.granted) {
    //     print("Location location.hasPermission(): " +
    //         _permissionGranted.toString());
    //     //return;
    //   }
    // }
  }

  static Future bluetooth() async {
    FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
    bluetooth.isOn.then((isOn) {
      print("FlutterBluetoothSerial isOn: " + isOn.toString());
      if (!isOn) {
        print("## Alert Turn On Bluetooth ## -- FlutterBluetoothSerial isOn: " +
            isOn.toString());
        bluetooth.openSettings;
        // .then((settings) {
        //   print("bluetooth.openSettings: " + settings.toString());
        // });
      }
    });
  }
}
