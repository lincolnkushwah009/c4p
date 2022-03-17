import 'package:flutter/material.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'empty.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function onTap;

  final TextStyle textFormFieldStyle;
  final TextStyle fieldTitleTextStyle;
  final TextStyle hintTextStyle;
  final BorderStyle borderStyle;
  final double borderRadius;
  final double borderWidth;
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
  final bool hasTitle;
  final String fieldTitle;
  final double elevation;
  final double prefixIconHeight;
  final TextInputType keyboardType;
  final Function onChanged;
  final String errorText;
  final String initialValue;
  final TextCapitalization textCapitalization;

  CustomTextFormField(
      {this.hasPrefixIcon = false,
      this.controller,
      this.prefixIcon,
      this.prefixIconHeight,
      this.maxLines = 1,
      this.textFormFieldStyle,
      this.fieldTitleTextStyle,
      this.hintTextStyle,
      this.borderStyle = BorderStyle.none,
      this.borderRadius = Sizes.RADIUS_6,
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
      this.elevation = Sizes.ELEVATION_0,
      this.onChanged,
      this.keyboardType = TextInputType.text,
      this.initialValue,
      this.textCapitalization,
      this.onTap,
      this.errorText});

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
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hasTitle
              ? formFieldTitle(
                  fieldTitle: fieldTitle,
                  textStyle: fieldTitleTextStyle ?? titleTextStyle)
              : Empty(),
          // Material(
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(borderRadius)),
          //   elevation: elevation,
          //   shadowColor: Colors.grey,
          // child:
          TextFormField(
            textCapitalization: textCapitalization,
            controller: controller,
            initialValue: initialValue,
            onTap: onTap,
            cursorColor: AppColors.primaryColor,
            style: textFormFieldStyle ?? formTextStyle,
            maxLines: maxLines,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: borderColor,
                  width: borderWidth,
                  style: borderStyle,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: enabledBorderColor,
                  width: borderWidth,
                  style: borderStyle,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: focusedBorderColor,
                  width: borderWidth,
                  style: borderStyle,
                ),
              ),
              suffixIcon: hasSuffixIcon ? suffixIcon : null,
              prefixIcon: hasPrefixIcon
                  ? Padding(
                      padding: EdgeInsets.only(
                          right: Sizes.PADDING_12, left: Sizes.PADDING_12),
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
                          Container(),
                    )
                  : null,
              contentPadding: EdgeInsets.symmetric(
                horizontal: contentPaddingHorizontal,
                vertical: contentPaddingVertical,
              ),
              hintText: hintText,
              hintStyle: hintTextStyle ?? formHintTextStyle,
              filled: filled,
              fillColor: fillColor,
              errorText: errorText,
            ),
            obscureText: obscured,
            keyboardType: keyboardType,
            onChanged: onChanged,
          ),
          // ),
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
