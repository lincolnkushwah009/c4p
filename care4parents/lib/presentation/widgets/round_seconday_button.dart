import 'package:care4parents/presentation/widgets/custom_button.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';

class RoundSecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final ThemeData theme;
  final String title;
  final Color textColor;
  final Color backgroundColor;

  const RoundSecondaryButton(
      {Key key,
      @required this.theme,
      @required this.title,
      @required this.onPressed,
      this.textColor = AppColors.primaryColor,
      this.backgroundColor = AppColors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        color: backgroundColor,
        height: Sizes.HEIGHT_48,
        borderRadius: Sizes.RADIUS_20,
        elevation: Sizes.ELEVATION_6,
        textStyle: theme.textTheme.bodyText1.copyWith(
          color: textColor,
        ),
        onPressed: onPressed,
        title: title);
  }
}
