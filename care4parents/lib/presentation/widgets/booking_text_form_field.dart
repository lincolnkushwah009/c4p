import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/widgets/custom_card_text_filed.dart';
import 'package:care4parents/presentation/widgets/custom_text_form_field.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';

class BookingTextFormField extends StatelessWidget {
  const BookingTextFormField({
    Key key,
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
    this.hasSuffixIcon = false,
    this.suffixIcon,
    this.fieldTitle,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  final String hintText;
  final String fieldTitle;
  final String prefixIcon;
  final double prefixIconHeight;
  final double borderRadius;
  final bool hasPrefixIconColor;
  final TextInputType keyboardType;
  final bool obscured;
  final Function onChanged;
  final Function onTap;
  final TextEditingController controller;
  final String errorText;
  final String initialValue;
  final Widget suffixIcon;
  final bool hasSuffixIcon;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    double width = assignWidth(context: context, fraction: 1.0);

    ThemeData theme = Theme.of(context);
    TextStyle hintTextStyle = theme.textTheme.bodyText2.copyWith(
      color: AppColors.blackShade10,
    );
    TextStyle titleTextStyle =
        theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700);
    TextStyle formTextStyle = theme.textTheme.subtitle2.copyWith(
      color: AppColors.black50,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_16),
      child: CustomTextFormField(
          controller: controller != null ? controller : null,
          initialValue: initialValue != null ? initialValue : null,
          onTap: onTap,
          hasTitle: true,
          hintText: hintText,
          fieldTitle: fieldTitle,
          suffixIcon: suffixIcon,
          hasSuffixIcon: hasSuffixIcon,
          textCapitalization: textCapitalization,

          // inputWidth: width * 0.9,
          // filled: true,
          // hintTextStyle: hintTextStyle,
          // fieldTitleTextStyle: titleTextStyle,
          // textFormFieldStyle: formTextStyle,
          // fillColor: AppColors.grey10,
          // obscured: obscured,
          // borderStyle: BorderStyle.none,
          // hasPrefixIcon: prefixIcon != null ? true : false,
          // prefixIcon: prefixIcon,
          // prefixIconColor:
          //     hasPrefixIconColor == true ? AppColors.primaryColor : null,
          // borderRadius: borderRadius != null ? borderRadius : Sizes.RADIUS_6,
          // borderColor: AppColors.white,
          // elevation: Sizes.ELEVATION_2,
          // prefixIconHeight: prefixIconHeight,
          // contentPaddingHorizontal: Sizes.PADDING_0,
          // onChanged: onChanged,
          // errorText: errorText,
          filled: true,
          hintTextStyle: hintTextStyle,
          fieldTitleTextStyle: titleTextStyle,
          textFormFieldStyle: formTextStyle,
          fillColor: AppColors.grey10,
          obscured: obscured,
          borderStyle: BorderStyle.none,
          hasPrefixIcon: false,
          borderRadius: Sizes.RADIUS_10,
          borderColor: AppColors.greyShade3,
          onChanged: onChanged,
          contentPaddingVertical: Sizes.dimen_2.h,
          contentPaddingHorizontal: Sizes.dimen_10.w,
          keyboardType: keyboardType,
          errorText: errorText),
    );
  }
}
