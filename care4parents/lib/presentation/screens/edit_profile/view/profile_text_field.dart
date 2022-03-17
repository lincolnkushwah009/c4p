import 'package:care4parents/presentation/widgets/custom_card_text_filed.dart';
import 'package:care4parents/presentation/widgets/custom_text_form_field.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';

class ProfileTextFormField extends StatelessWidget {
  const ProfileTextFormField(
      {Key key,
      this.prefixIcon,
      this.prefixIconHeight,
      this.hintText,
      this.hasPrefixIconColor = true,
      this.obscured = false,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.errorText,
      this.initialValue,
      this.fieldTitle})
      : super(key: key);

  final String hintText;
  final String fieldTitle;
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
    TextStyle hintTextStyle = theme.textTheme.bodyText2.copyWith(
      color: AppColors.blackShade10,
    );
    TextStyle titleTextStyle =
        theme.textTheme.bodyText2.copyWith(fontWeight: FontWeight.w700);
    TextStyle formTextStyle = theme.textTheme.subtitle2.copyWith(
      color: AppColors.black50,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_24),
      child: CustomTextFormField(
          initialValue: initialValue,
          hasTitle: fieldTitle != null ? true : false,
          fieldTitle: fieldTitle,
          hintText: hintText,
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
