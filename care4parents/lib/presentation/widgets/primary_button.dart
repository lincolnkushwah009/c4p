import 'package:care4parents/presentation/widgets/custom_button.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final ThemeData theme;
  final String title;
  final Color backgroundColor;

  const PrimaryButton({
    Key key,
    @required this.theme,
    @required this.title,
    this.backgroundColor,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        color: backgroundColor != null ? backgroundColor :AppColors.primaryColor,
        height: Sizes.HEIGHT_48,
        borderRadius: Sizes.RADIUS_8,
        textStyle: theme.textTheme.headline6.copyWith(
          color: AppColors.white,
        ),
        onPressed: onPressed,
        title: title);
  }
}
