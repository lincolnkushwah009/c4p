import 'package:flutter/material.dart';
import 'package:care4parents/values/values.dart';

class Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.HEIGHT_2,
      width: Sizes.WIDTH_80,
      padding: EdgeInsets.only(
        top: Sizes.PADDING_2,
        bottom: Sizes.PADDING_4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Sizes.RADIUS_4)),
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.secondaryColor,
          ],
        ),
      ),
    );
  }
}
