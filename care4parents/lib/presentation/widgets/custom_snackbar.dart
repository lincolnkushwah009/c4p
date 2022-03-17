//Custom class in project directory
import 'package:flutter/material.dart';

class SnackBarWidgets {
  SnackBarWidgets._();
  static buildErrorSnackbar(BuildContext context, String message) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Text("$message"),
        ),
      );
  }
}
