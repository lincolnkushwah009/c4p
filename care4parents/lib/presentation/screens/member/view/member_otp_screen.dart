import 'package:auto_route/auto_route.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/auth/auth_app_bar.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_snackbar.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/round_seconday_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../member.dart';

class MemberOtpScreen extends StatefulWidget {
  final String phone, type;
  MemberOtpScreen({Key key, @required this.phone, this.type}) : super(key: key);

  @override
  _MemberOtpScreenState createState() => _MemberOtpScreenState(phone, type);
}

class _MemberOtpScreenState extends State<MemberOtpScreen> {
  MemberBloc _memberBloc;
  final String phone, type;
  _MemberOtpScreenState(this.phone, this.type); //constructor
  @override
  void initState() {
    super.initState();
    _memberBloc = getItInstance<MemberBloc>();
    _memberBloc.add(MemberPhoneNumberChanged(phone, type));
    _memberBloc.add(MemberTypeChanged(type));
    print("type====>>==" + type.toString());
  }

  @override
  Widget build(BuildContext context) {
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
                  child: BlocProvider(
                    create: (context) => _memberBloc,
                    child: _otpLayout(context, type),
                  ),
                ),
                // Container(
                //   height: heightOfScreen * 0.8,
                //   child: BlocProvider(
                //     create: (context) => _memberBloc,
                //     child: PhoneNumberForm(),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _otpLayout(BuildContext context, String type) {
  ThemeData theme = Theme.of(context);
  double widthOfScreen = assignWidth(context: context, fraction: 1.0);
  double heightOfScreen = assignHeight(context: context, fraction: 1.0);

  return ListView(
    children: [
      SpaceH20(),
      Center(
        child: Text(
          StringConst.sentence.ENTER_CODE,
          style: theme.textTheme.headline6.copyWith(
            fontWeight: FontWeight.w200,
            color: AppColors.tersaryText,
          ),
        ),
      ),
      Center(
        child: Text(
          StringConst.sentence.OTP_CODE,
          style: theme.textTheme.headline5.copyWith(
              // fontWeight: FontWeight.bold,
              color: AppColors.greenShade2,
              letterSpacing: 10),
        ),
      ),
      Center(
        child: Text(
          StringConst.sentence.OTP_CODE_DESC,
          style: theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.w200,
            color: AppColors.secodaryText,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      SpaceH20(),
      BgCard(
        width: widthOfScreen * 0.8,
        height: heightOfScreen * 0.35,
        borderRadius: const BorderRadius.all(
          const Radius.circular(Sizes.RADIUS_10),
        ),
        child: OtpForm(),
      ),
      SpaceH20(),
      Center(
        child: Text(
          StringConst.sentence.DNRC,
          style: theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.w200,
            color: AppColors.blackShade3,
          ),
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
          // Text(
          //   CommonButtons.GET_A_CALL_NOW,
          //   // recognizer: onTapRecognizer,
          //   style: theme.textTheme.bodyText1.copyWith(
          //     fontWeight: FontWeight.w200,
          //     color: AppColors.primaryColor,
          //   ),
          // ),
        ],
      ),
      SpaceH48(),
    ],
  );
}

class OtpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = assignWidth(context: context, fraction: 1.0);
    return BlocListener<MemberBloc, MemberState>(
      listener: (context, state) {
        if (state.status1.isSubmissionFailure) {
          SnackBarWidgets.buildErrorSnackbar(
              context, StringConst.sentence.LOGIN_FAILED);
        }
        print('right error sonu>>ddddd>>>');
        if (state.status1.isSubmissionSuccess && state.type.value == 'member') {
          ExtendedNavigator.root
              .pushAndRemoveUntil(Routes.recordVitalScreen, (route) => false);
        }
        if (state.status1.isSubmissionSuccess && state.type.value != 'member') {
          ExtendedNavigator.root
              .pushAndRemoveUntil(Routes.HomeTypeScreen, (route) => false);
        }
      },
      child: Column(
        children: [
          _OtpInput(),
          SpaceH20(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_24),
            child: _SubmitButton(),
          ),
        ],
      ),
    );
  }
}

class _OtpInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberBloc, MemberState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
          child: PinCodeTextField(
            key: const Key('MemberForm_OptInput_textField'),
            appContext: context,
            pastedTextStyle: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
            length: 4,
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
            // errorAnimationController: errorController,
            keyboardType: TextInputType.number,
            onCompleted: (otp) {
              print("Completed");
              context.read<MemberBloc>().add(MemberOtpChanged(otp));
            },
            onTap: () {
              print("Pressed");
            },
            onChanged: (otp) {
              print(otp);
            },
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<MemberBloc, MemberState>(
      buildWhen: (previous, current) => previous.status1 != current.status1,
      builder: (context, state) {
        return state.status1.isSubmissionInProgress
            ? const AppLoading()
            : RoundSecondaryButton(
                title: CommonButtons.SUBMIT,
                theme: theme,
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.white,
                onPressed: state.status1.isValidated
                    ? () {
                        print(state.status1.isValidated);
                        context.read<MemberBloc>().add(const MemberOtpSubmit());
                      }
                    : () {
                        print(state.otp);
                        SnackBarWidgets.buildErrorSnackbar(
                            context, StringConst.sentence.EMPTY_OTP);
                      },
              );
      },
    );
  }
}
