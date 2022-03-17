import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/presentation/widgets/auth/auth_app_bar.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/round_seconday_button.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:flutter/material.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/values/values.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  String currentText = "";
  int pinLength = 4;

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AuthAppBar(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_32),
                  height: heightOfScreen * 0.8,
                  child: _otpLayout(context),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: new whatappIconwidget(isHeader: false),
    );
  }

  Widget _otpLayout(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);

    return Column(
      children: [
        SpaceH96(),
        Text(
          StringConst.sentence.ENTER_CODE,
          style: theme.textTheme.headline6.copyWith(
            fontWeight: FontWeight.w200,
            color: AppColors.tersaryText,
          ),
        ),
        Text(
          StringConst.sentence.OTP_CODE,
          style: theme.textTheme.headline5.copyWith(
              // fontWeight: FontWeight.bold,
              color: AppColors.greenShade2,
              letterSpacing: 10),
        ),
        Text(
          StringConst.sentence.OTP_CODE_DESC,
          style: theme.textTheme.subtitle1.copyWith(
            fontWeight: FontWeight.w200,
            color: AppColors.secodaryText,
          ),
          textAlign: TextAlign.center,
        ),
        SpaceH48(),
        BgCard(
          width: widthOfScreen * 0.8,
          height: heightOfScreen * 0.25,
          borderRadius: const BorderRadius.all(
            const Radius.circular(Sizes.RADIUS_10),
          ),
          child: _otpForm(context),
        ),
        SpaceH20(),
        Text(
          StringConst.sentence.DNRC,
          style: theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.w200,
            color: AppColors.blackShade3,
          ),
        ),
        SpaceH20(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                ExtendedNavigator.root.pop();
              },
              child: Text(
                'Go to Sign in',
                // recognizer: onTapRecognizer,
                style: theme.textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w200,
                  color: AppColors.primaryColor,
                ),
              ),
            )
            //     Text(
            //       CommonButtons.GET_A_CALL_NOW,
            //       // recognizer: onTapRecognizer,
            //       style: theme.textTheme.bodyText1.copyWith(
            //         fontWeight: FontWeight.w200,
            //         color: AppColors.primaryColor,
            //       ),
            //     ),
          ],
        ),
      ],
    );
  }

  Widget _otpForm(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
            child: PinCodeTextField(
              appContext: context,
              pastedTextStyle: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
              length: pinLength,
              animationType: AnimationType.fade,
              validator: (v) {},
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                fieldHeight: 40,
                fieldWidth: 40,
                activeFillColor: AppColors.white,
                inactiveFillColor: AppColors.white,
                activeColor: AppColors.primaryColor,
                inactiveColor: AppColors.greyShade6,
                selectedColor: AppColors.primaryColor,
                disabledColor: AppColors.greyShade6,
                selectedFillColor: AppColors.white,
                borderWidth: 1,
              ),
              cursorColor: AppColors.black,
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: AppColors.white,
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: textEditingController,
              keyboardType: TextInputType.number,
              onCompleted: (v) {
                print("Completed");
              },
              onTap: () {
                print("Pressed");
              },
              onChanged: (value) {
                print(value);
                setState(() {
                  currentText = value;
                });
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
          ),
        ),
        RoundSecondaryButton(
            onPressed: () {
              onPressSubmit();
            },
            title: CommonButtons.SUBMIT,
            theme: theme,
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.white),
      ],
    );
  }
}

void onPressSubmit() {
  ExtendedNavigator.root.push(Routes.homeScreen);
}
