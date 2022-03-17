import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: AppColors.primaryColor,
              strokeWidth: 5,
              valueColor: new AlwaysStoppedAnimation<Color>(AppColors.grey),
            )
          ],
        ),
      ),
    );
  }
}
