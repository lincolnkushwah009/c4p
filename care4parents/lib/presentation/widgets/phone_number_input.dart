import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/values/values.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'bg_card.dart';
import 'empty.dart';

// import 'custom_card_text_filed.dart';

// import '../custom_card_text_filed.dart';

class PhoneCardTextFormField extends StatelessWidget {
  const PhoneCardTextFormField({
    Key key,
    this.prefixIcon,
    this.prefixIconHeight,
    this.hintText,
    this.hasPrefixIconColor = true,
    this.obscured = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onChangedC,
    this.country_code,
    this.errorText,
    this.initialValue,
     this.controller
  }) : super(key: key);
  final String initialValue;
  final String hintText;
  final String prefixIcon;
  final double prefixIconHeight;
  final bool hasPrefixIconColor;
  final TextInputType keyboardType;
  final bool obscured;
  final Function onChanged;
  final Function onChangedC;
  final String errorText;
  final  String country_code;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle hintTextStyle = theme.textTheme.bodyText2;
    TextStyle titleTextStyle = theme.textTheme.subtitle1;
    TextStyle formTextStyle = theme.textTheme.subtitle2.copyWith(
      color: AppColors.black50,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_10),
      child: CustomCardTextFormField(
        controller: controller,
          hintText: hintText,
          filled: true,
          hintTextStyle: hintTextStyle,
          fieldTitleTextStyle: titleTextStyle,
          textFormFieldStyle: formTextStyle,
          fillColor: AppColors.white,
          obscured: obscured,
          borderStyle: BorderStyle.none,
          hasPrefixIcon: true,
          prefixIcon: prefixIcon,
          onChangedC: onChangedC,
          prefixIconColor:
              hasPrefixIconColor == true ? AppColors.blackShade3 : null,
          borderRadius: Sizes.RADIUS_40,
          borderColor: AppColors.grey,
          keyboardType: keyboardType,
          // borderWidth: Sizes.HEIGHT_1,
          focusedBorderColor: AppColors.primaryColor,
          elevation: Sizes.ELEVATION_1,
          prefixIconHeight: prefixIconHeight,
          onChanged: onChanged,
          country_code: country_code,
          errorText: errorText,
          initialValue:initialValue,),
    );
  }
}

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
  final Function onChangedC;
  final Function onTap;
  final String errorText;
  final String initialValue;
  final String country_code;

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
      this.country_code,
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
      this.onChangedC,
      this.errorText,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    print('country_code ++++' + country_code);
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
            padding:
                EdgeInsets.only(left: 16.0, right: 8.0, top: 8.0, bottom: 8.0),
            backgroundColor: fillColor,
            width: inputWidth != null ? inputWidth : width * 0.8,
            height: Sizes.HEIGHT_56,
            borderRadius: BorderRadius.circular(borderRadius),
            borderColor: (borderColor != null && errorText != null)
                ? AppColors.errorColor
                : borderColor,
            child: TextFormField(
              autofocus: false,
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
                // contentPadding:
                //     EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                suffixIcon: hasSuffixIcon ? suffixIcon : null,
                prefixIcon: hasPrefixIcon
                    ? Padding(
                        padding: EdgeInsets.only(
                            right: Sizes.PADDING_0, left: Sizes.PADDING_0),
                        child: Container(
                                alignment: Alignment.center,
                                height: Sizes.ICON_SIZE_16,
                                width: Sizes.ICON_SIZE_40,
                                child: InkWell(
                                    onTap: () {
                                      showCountryPicker(
                                          context: context,
                                          //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                          exclude: <String>['KN', 'MF'],
                                          //Optional. Shows phone code before the country name.
                                          showPhoneCode: true,
                                          onSelect: (Country country) =>
                                              onChangedC(country)
                                          //  {
                                          //   onChangedC(country);
                                          //   print(
                                          //       'Select country: ${country.displayName}');
                                          // },
                                          );
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            country_code.toString() != 'null'
                                                ? '+${country_code}'
                                                : '+91',
                                            style: theme.textTheme.caption
                                                .copyWith(
                                                    color:
                                                        AppColors.blackShade4)),
                                        Icon(Icons.keyboard_arrow_down,
                                            color: AppColors.blackShade4,
                                            size: 14)
                                      ],
                                    ))) ??
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
