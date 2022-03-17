import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/signup/bloc/signup_bloc.dart';
import 'package:care4parents/presentation/screens/signup/models/models.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/auth/auth_text_form_field.dart';
import 'package:care4parents/presentation/widgets/auth/social_button.dart';
import 'package:care4parents/presentation/widgets/custom_snackbar.dart';
import 'package:care4parents/presentation/widgets/phone_number_input.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:country_picker/country_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import '../Signup.dart';

void onFacebookBtnPress() {
  ExtendedNavigator.root.push(Routes.welcomeScreen);
}

void onGoogleBtnPress() {
  ExtendedNavigator.root.push(Routes.welcomeScreen);
}

class SignUpForm extends StatelessWidget {
  static final facebookAppEvents = FacebookAppEvents();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = assignWidth(context: context, fraction: 1.0);
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) async {
        if (state.status.isSubmissionFailure) {
          failureSnackBar(context, message: state.error);
        }

        if (state.status.isSubmissionSuccess) {
          facebookAppEvents.logEvent(
            name: 'register_c4p',
            parameters: {
              'button_id': '112',
            },
          );
          ExtendedNavigator.root
              .pushAndRemoveUntil(Routes.loginScreen, (route) => false);
          // Future.delayed(const Duration(milliseconds: 500), () {
          // if (result != null && result == true) {
          print('state  message =====>' + state.error);

          // successSnackBar(context, message: state.error);
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey[200],
              textColor: Colors.black,
              fontSize: 16.0);
          // }
          // });
        }
      },
      child: new Column(
        children: [
          SpaceH16(),
          Center(
            child: Text(
              StringConst.sentence.GYR,
              style: theme.textTheme.subtitle1.copyWith(
                color: AppColors.blackShade3,
              ),
            ),
          ),
          SpaceH8(),
          _NameInput(),
          SpaceH8(),
          _EmailInput(),
          SpaceH8(),
          _PhoneNumberInput(),
          SpaceH8(),
          _PasswordInput(),
          SpaceH24(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_24),
            child: _SignupButton(),
          ),
          SpaceH24(),
        ],
      ),
    );
  }

  void failureSnackBar(BuildContext context, {String message = null}) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
            duration: Duration(seconds: 5),
            content: Text(message != null
                ? message
                : StringConst.sentence.SIGNUP_FAILED)),
      );
  }

  void successSnackBar(BuildContext context, {String message = null}) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
            content:
                Text(message != null ? message : 'Please verify your email.')),
      );
  }
}

class _Social extends StatelessWidget {
  const _Social({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SocialButton(
              width: width,
              title: StringConst.sentence.GOOGLE,
              icon: ImagePath.GOOGLE_ICON,
              onPressed: () {
                onGoogleBtnPress();
              }),
          SpaceW12(),
          SocialButton(
              width: width,
              title: StringConst.sentence.FACEBOOK,
              icon: ImagePath.FACEBOOK_ICON,
              onPressed: () {
                onFacebookBtnPress();
              }),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Center(
          child: AuthTextFormField(
            key: const Key('SignUpForm_emailInput_textField'),
            hintText: StringConst.label.EMAIL,
            prefixIcon: ImagePath.EMAIL_ICON,
            prefixIconHeight: Sizes.ICON_SIZE_14,
            onChanged: (email) =>
                context.read<SignupBloc>().add(SignupEmailChanged(email)),
            errorText: state.email.error == EmailValidationError.invalid
                ? StringConst.sentence.INVALID_EMAIL
                : state.email.invalid
                    ? StringConst.sentence.EMPTY_EMAIL
                    : null,
          ),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Center(
          child: AuthTextFormField(
            key: const Key('SignUpForm_NameInput_textField'),
            hintText: StringConst.label.NAME,
            prefixIcon: ImagePath.USER_ICON,
            prefixIconHeight: Sizes.ICON_SIZE_14,
            onChanged: (name) =>
                context.read<SignupBloc>().add(SignupNameChanged(name)),
            errorText:
                state.name.invalid ? StringConst.sentence.EMPTY_NAME : null,
          ),
        );
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) =>
          previous.username != current.username ||
          previous.country_code != current.country_code,
      builder: (context, state) {
        print('country_code-----------' + state.country_code.toString());
        return Center(
          child: PhoneCardTextFormField(
            // key: const Key('SignUpForm_PhoneNumberInput_textField'),
            hintText: StringConst.label.MOBILE_NUMBER,
            prefixIcon: ImagePath.INDIA_FLAG_ICON,
            hasPrefixIconColor: false,
            prefixIconHeight: Sizes.ICON_SIZE_14,
            keyboardType: TextInputType.phone,
            onChangedC: (country) => context
                .read<SignupBloc>()
                .add(SignupCodeChanged(country.phoneCode)),
            country_code: state.country_code.value,
            onChanged: (username) =>
                context.read<SignupBloc>().add(SignupUserNameChanged(username)),
            errorText: state.username.invalid
                ? StringConst.sentence.EMPTY_MOBILE
                : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Center(
          child: AuthTextFormField(
            key: const Key('SignUpForm_passwordInput_textField'),
            hintText: StringConst.label.PASSWORD,
            prefixIcon: ImagePath.LOCK_ICON,
            prefixIconHeight: Sizes.ICON_SIZE_18,
            obscured: true,
            onChanged: (password) =>
                context.read<SignupBloc>().add(SignupPasswordChanged(password)),
            errorText: state.password.invalid
                ? StringConst.sentence.EMPTY_PASSWORD
                : null,
          ),
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const AppLoading()
            : PrimaryButton(
                onPressed: state.status.isValidated
                    ? () {
                        print(state.email.toString());
                        print(state.username.toString());
                        print(state.name.toString());
                        print(state.password.toString());


                        context.read<SignupBloc>().add(const SignupSubmitted());
                      }
                    : () {

                        SnackBarWidgets.buildErrorSnackbar(
                            context, StringConst.sentence.EMPTY_FILED);
                        print('demddo');
                      },
                title: CommonButtons.NEXT,
                theme: Theme.of(context),
              );
      },
    );
  }
}
