import 'package:flutter/material.dart';
import 'package:care4parents/values/values.dart';

class BgCardAuto extends StatelessWidget {
  BgCardAuto({
    this.borderColor,
    this.width = Sizes.WIDTH_60,
    this.height = Sizes.HEIGHT_60,
    this.borderWidth = 0.5,
    this.padding = const EdgeInsets.symmetric(
      horizontal: Sizes.PADDING_16,
      vertical: Sizes.PADDING_16,
    ),
    this.backgroundColor = AppColors.white,
    this.borderRadius = const BorderRadius.all(
      const Radius.circular(Sizes.RADIUS_4),
    ),
    this.shadow = Shadows.bgCardShadow,
    this.gradient,
    this.child,
  });
  final Color borderColor;
  final double width;
  final double height;
  final double borderWidth;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final BorderRadiusGeometry borderRadius;
  final BoxShadow shadow;
  final Widget child;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: this.width,

      decoration: BoxDecoration(
        gradient: this.gradient,
        border: Border.all(
            color: borderColor != null ? borderColor : AppColors.white,
            width: borderWidth),
        color: this.backgroundColor,
        borderRadius: borderRadius,
        boxShadow: [shadow],
      ),
      child: child ?? Container(),
    );
  }
}
