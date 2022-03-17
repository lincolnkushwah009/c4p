import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';

import '../custom_card_text_filed.dart';

class AuthTextFormField extends StatelessWidget {
   AuthTextFormField({
    Key key,
    this.prefixIcon,
    this.prefixIconHeight,
    this.hintText,
    this.hasPrefixIconColor = true,
    this.obscured = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.errorText,
     this.controller,
     this.initialValue
  }) : super(key: key);
   final TextEditingController controller;
  final String hintText;
  final String prefixIcon;
  final double prefixIconHeight;
  final bool hasPrefixIconColor;
  final TextInputType keyboardType;
  final bool obscured;
  final Function onChanged;
  final String errorText;
   final String initialValue;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle hintTextStyle = theme.textTheme.bodyText2;
    TextStyle titleTextStyle = theme.textTheme.subtitle1;
    TextStyle formTextStyle = theme.textTheme.subtitle2.copyWith(
      color: AppColors.black50,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_24),
      child: CustomCardTextFormField(
          initialValue:initialValue,
          hintText: hintText,
          controller: controller,
          filled: true,
          hintTextStyle: hintTextStyle,
          fieldTitleTextStyle: titleTextStyle,
          textFormFieldStyle: formTextStyle,
          fillColor: AppColors.white,
          obscured: obscured,
          borderStyle: BorderStyle.none,
          hasPrefixIcon: true,
          prefixIcon: prefixIcon,
          prefixIconColor:
              hasPrefixIconColor == true ? AppColors.blackShade3 : null,
          borderRadius: Sizes.RADIUS_40,
          borderColor: AppColors.grey,
          keyboardType: keyboardType,
          borderWidth: Sizes.HEIGHT_1,
          focusedBorderColor: AppColors.primaryColor,
          elevation: Sizes.ELEVATION_1,
          prefixIconHeight: prefixIconHeight,
          onChanged: onChanged,
          errorText: errorText),
    );
  }
}
