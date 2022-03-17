import 'package:care4parents/presentation/widgets/custom_button.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  const SocialButton(
      {Key key,
      @required this.width,
      @required this.title,
      @required this.icon,
      @required this.onPressed})
      : super(key: key);

  final double width;
  final String title;
  final String icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.35,
      child: CustomButton(
        elevation: Sizes.ELEVATION_4,
        onPressed: onPressed,
        borderRadius: Sizes.RADIUS_8,
        color: AppColors.white,
        hasIcon: true,
        title: title,
        icon: SvgPicture.asset(
          icon,
        ),
      ),
    );
  }
}
