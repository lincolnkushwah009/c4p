import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/widgets/custom_card_text_filed.dart';
import 'package:care4parents/presentation/widgets/custom_text_form_field.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';

class BookingTextFormField1 extends StatelessWidget {
  const BookingTextFormField1(
      {Key key,
      this.prefixIcon,
      this.prefixIconHeight,
      @required this.hintText,
      this.hasPrefixIconColor = true,
      this.obscured = false,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.onTap,
      this.controller,
      this.errorText,
      this.borderRadius,
      this.initialValue,
      this.elevation,
      this.inputWidth})
      : super(key: key);

  final String hintText;
  final String prefixIcon;
  final double prefixIconHeight;
  final double borderRadius;
  final double inputWidth;
  final double elevation;
  final bool hasPrefixIconColor;
  final TextInputType keyboardType;
  final bool obscured;
  final Function onChanged;
  final Function onTap;
  final TextEditingController controller;
  final String errorText;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    double width = assignWidth(context: context, fraction: 1.0);

    ThemeData theme = Theme.of(context);
    TextStyle hintTextStyle = theme.textTheme.bodyText2;
    TextStyle titleTextStyle = theme.textTheme.subtitle1;
    TextStyle formTextStyle = theme.textTheme.subtitle2.copyWith(
      color: AppColors.black,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_16),
      child: CustomCardTextFormField(
        controller: controller != null ? controller : null,
        initialValue: initialValue != null ? initialValue : null,
        onTap: onTap,
        hasTitle: false,
        hintText: hintText,
        inputWidth: inputWidth != null ? inputWidth : width * 0.9,
        filled: true,
        hintTextStyle: hintTextStyle,
        fieldTitleTextStyle: titleTextStyle,
        textFormFieldStyle: formTextStyle,
        fillColor: AppColors.white,
        obscured: obscured,
        borderStyle: BorderStyle.none,
        hasPrefixIcon: prefixIcon != null ? true : false,
        prefixIcon: prefixIcon,
        prefixIconColor:
            hasPrefixIconColor == true ? AppColors.primaryColor : null,
        borderRadius: borderRadius != null ? borderRadius : Sizes.RADIUS_6,
        borderColor: AppColors.white,
        elevation: elevation != null ? elevation : Sizes.ELEVATION_2,
        prefixIconHeight: prefixIconHeight,
        contentPaddingHorizontal: Sizes.PADDING_0,
        onChanged: onChanged,
        errorText: errorText,
      ),
    );
  }
}
