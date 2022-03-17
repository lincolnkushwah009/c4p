import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'bg_card.dart';
import 'empty.dart';

class CustomCardTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextStyle textFormFieldStyle;
  final TextStyle fieldTitleTextStyle;
  final TextStyle hintTextStyle;
  final BorderStyle borderStyle;
  final double borderRadius;
  final double borderWidth;
  final double inputWidth;
  final double contentPaddingHorizontal;
  final double contentPaddingVertical;
  final String prefixIcon;
  final String hintText;
  final Color prefixIconColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final Color fillColor;
  final bool filled;
  final bool obscured;
  final bool hasPrefixIcon;
  final bool hasSuffixIcon;
  final Widget suffixIcon;
  final int maxLines;
  final int minLines;
  final bool hasTitle;
  final String fieldTitle;
  final double elevation;
  final double prefixIconHeight;
  final TextInputType keyboardType;
  final Function onChanged;
  final Function onTap;
  final String errorText;
  final String initialValue;

  CustomCardTextFormField(
      {this.hasPrefixIcon = false,
      this.prefixIcon,
      this.controller,
      this.prefixIconHeight,
      this.maxLines = 1,
      this.minLines = 1,
      this.textFormFieldStyle,
      this.fieldTitleTextStyle,
      this.hintTextStyle,
      this.borderStyle = BorderStyle.none,
      this.borderRadius = Sizes.RADIUS_0,
      this.borderWidth = Sizes.WIDTH_0,
      this.contentPaddingHorizontal = Sizes.PADDING_4,
      this.contentPaddingVertical = Sizes.PADDING_4,
      this.hintText,
      this.prefixIconColor = AppColors.primaryColor,
      this.borderColor = AppColors.grey,
      this.focusedBorderColor = AppColors.grey,
      this.enabledBorderColor = AppColors.grey,
      this.fillColor = AppColors.white,
      this.filled = true,
      this.obscured = false,
      this.hasTitle = false,
      this.suffixIcon,
      this.hasSuffixIcon = false,
      this.fieldTitle,
      this.elevation = Sizes.ELEVATION_4,
      this.onChanged,
      this.keyboardType = TextInputType.text,
      this.onTap,
      this.inputWidth,
      this.errorText,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle titleTextStyle = theme.textTheme.subtitle1;
    TextStyle formTextStyle = theme.textTheme.subtitle1.copyWith(
      color: AppColors.secondaryColor,
    );
    TextStyle formHintTextStyle = theme.textTheme.bodyText2.copyWith(
      color: AppColors.black,
    );
    double width = assignWidth(context: context, fraction: 1.0);

    return Container(
      margin: EdgeInsets.only(top: Sizes.MARGIN_16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hasTitle
              ? formFieldTitle(
                  fieldTitle: fieldTitle,
                  textStyle: fieldTitleTextStyle ?? titleTextStyle)
              : Empty(),
          BgCard(
            backgroundColor: fillColor,
            width: inputWidth != null ? inputWidth : width * 0.8,
            height: Sizes.HEIGHT_56,
            borderRadius: BorderRadius.circular(borderRadius),
            borderColor: (borderColor != null && errorText != null)
                ? AppColors.errorColor
                : borderColor,
            child: TextFormField(
              controller: controller,
              initialValue: initialValue,
              onTap: onTap,
              cursorColor: AppColors.primaryColor,
              style: textFormFieldStyle ?? formTextStyle,
              maxLines: maxLines,
              minLines: minLines,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                isDense: true,
                suffixIcon: hasSuffixIcon ? suffixIcon : null,
                prefixIcon: hasPrefixIcon
                    ? Padding(
                        padding: EdgeInsets.only(
                            right: Sizes.PADDING_12, left: Sizes.PADDING_0),
                        child: Container(
                              alignment: Alignment.center,
                              height: Sizes.ICON_SIZE_16,
                              width: Sizes.ICON_SIZE_16,
                              child: SvgPicture.asset(
                                prefixIcon,
                                color: prefixIconColor,
                                height: prefixIconHeight,
                                fit: BoxFit.fitHeight,
                              ),
                            ) ??
                            Container())
                    : null,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: contentPaddingHorizontal,
                  vertical: contentPaddingVertical,
                ),
                hintText: hintText,
                hintStyle: hintTextStyle ?? formHintTextStyle,
                filled: filled,
                fillColor: fillColor,
                // errorText: errorText,
              ),
              obscureText: obscured,
              keyboardType: keyboardType,
              onChanged: onChanged,
            ),
          ),
          errorText != null
              ? Text(
                  errorText,
                  style: theme.textTheme.caption.copyWith(
                    color: AppColors.redShade4,
                  ),
                  textAlign: TextAlign.left,
                )
              : Empty()
        ],
      ),
    );
  }

  Widget formFieldTitle({@required String fieldTitle, TextStyle textStyle}) {
    return Container(
      margin: EdgeInsets.only(bottom: Sizes.MARGIN_8),
      child: Text(
        fieldTitle,
        style: textStyle,
      ),
    );
  }
}
