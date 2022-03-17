import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/apple_login/apple_sign_in_button.dart';
import 'package:care4parents/helper/validation/users.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/auth/auth_text_form_field.dart';
import 'package:care4parents/presentation/widgets/auth/social_button.dart';
import 'package:care4parents/presentation/widgets/phone_number_input.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../login.dart';

void onGoogleBtnPress() {
  ExtendedNavigator.root.push(Routes.welcomeScreen);
}

// FacebookLogin facebookLogin;
// final fb = FacebookLogin();

void initiateFacebookLogin() async {
//   // facebookLogin = new FacebookLogin();
//   // var facebookLoginResult = await facebookLogin.logIn(['email']);
//   // switch (facebookLoginResult.status) {
//   //   case FacebookLoginStatus.error:
//   //     print("YOU GOT A ERROR");
//   //     // onLoginStatusChanged(false);
//   //     break;
//   //   case FacebookLoginStatus.cancelledByUser:
//   //     print("CancelledByUser");
//   //     // onLoginStatusChanged(false);
//   //     break;
//   //   case FacebookLoginStatus.loggedIn:
//   //     print("LoggedIn");
//   //     print('result.accessToken.token' + facebookLoginResult.accessToken.token);
//   //     // onLoginStatusChanged(true);
//   //     break;
//   // }
}
// Log in

// Future<Null> _login() async {
//   final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

//   switch (result.status) {
//     case FacebookLoginStatus.loggedIn:
//       final FacebookAccessToken accessToken = result.accessToken;
//       _showMessage('''
//          Logged in!

//          Token: ${accessToken.token}
//          User id: ${accessToken.userId}
//          Expires: ${accessToken.expires}
//          Permissions: ${accessToken.permissions}
//          Declined permissions: ${accessToken.declinedPermissions}
//          ''');
//       break;
//     case FacebookLoginStatus.cancelledByUser:
//       _showMessage('Login cancelled by the user.');
//       break;
//     case FacebookLoginStatus.error:
//       _showMessage('Something went wrong with the login process.\n'
//           'Here\'s the error Facebook gave us: ${result.errorMessage}');
//       break;
//   }
// }

class LoginForm extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginForm> {
  //static final facebookAppEvents = FacebookAppEvents();
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // context.read<LoginBloc>().add(LoginEmailChanged("web@pinkshastra.com"));
    // context.read<LoginBloc>().add(LoginPasswordChanged("123456"));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = assignWidth(context: context, fraction: 1.0);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          failureSnackBar(context, message: state.error);
        }

        if (state.status.isSubmissionSuccess && state.email.value != "") {
          print('login success---------------');
          ExtendedNavigator.root
              .pushAndRemoveUntil(Routes.HomeTypeScreen, (route) => false);

          // ExtendedNavigator.root.push(Routes.HomeTypeScreen);
        } else if (state.status.isSubmissionSuccess &&
            state.username.value != "") {
          ExtendedNavigator.root.push(Routes.memberOtpScreen,
              arguments: MemberOtpScreenArguments(
                  phone: state.username.value, type: "login"));
        }
      },
      child: Column(
        children: [
          SpaceH16(),
          Center(
            child: Text(
              StringConst.sentence.LOG_IN,
              style: theme.textTheme.headline5.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
          SpaceH8(),
          _EmailInput(controller: controller),
          SpaceH8(),
          _PasswordInput(),
          SpaceH8(),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                ExtendedNavigator.root.push(Routes.forgotPasswordScreen);
              },
              child: Container(
                margin: const EdgeInsets.only(right: Sizes.PADDING_24),
                padding: const EdgeInsets.only(bottom: Sizes.PADDING_4),
                child: Text(
                  StringConst.sentence.FORGOT_PASSWORD,
                  style: theme.textTheme.bodyText2.copyWith(
                      color: AppColors.black, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              StringConst.WELCOME_OR,
              style: theme.textTheme.bodyText1,
            ),
          ),
          _PhoneNumberInput(),
          SpaceH20(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_24),
            child: _LoginButton(),
          ),
          SpaceH16(),
          Center(
            child: Text(
              StringConst.WELCOME_OR,
              style: theme.textTheme.bodyText1,
            ),
          ),
          SpaceH8(),
          _Social(width: width),
          SpaceH12(),
          if (Platform.isIOS)
            new Container(
              margin: const EdgeInsets.only(
                  left: Sizes.MARGIN_24,
                  right: Sizes.MARGIN_24,
                  bottom: Sizes.MARGIN_12),
              child: MaterialButton(
                elevation: Sizes.ELEVATION_4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.RADIUS_8),
                  side: Borders.defaultPrimaryBorder,
                ),
                color: AppColors.white,
                child: AppleSignInButton(
                  type: ButtonType.continueButton,
                  onPressed: () {
                    // appleLogIn(context);

                    BlocProvider.of<LoginBloc>(context).add(LoginToApple());
                  },
                ),
              ),
            )
          else
            new Container(),
          CreateAccountText(theme: theme),
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
            content: Text(
                message != null ? message : StringConst.sentence.LOGIN_FAILED)),
      );
  }

  // void appleLogIn(BuildContext context) async {
  // if (await AppleSignIn.isAvailable()) {
  //   print('sonu first');
  //   final AuthorizationResult result = await AppleSignIn.performRequests([
  //     AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
  //   ]);

  //   print('sonu sss>> ' + result.toString());
  //   switch (result.status) {
  //     case AuthorizationStatus.authorized:
  //       print(result.credential.user);

  //       var appleUser =
  //           parseJwt(utf8.decode(result.credential.identityToken));

  //       print(appleUser['email']);
  //       failureSnackBar(context,
  //           message: result.status.toString() +
  //               "" +
  //               result.credential.email.toString() +
  //               "" +
  //               result.credential.fullName.givenName.toString() +
  //               "" +
  //               appleUser['email'].toString());

  //       print('sonu sss');

  //       break; //All the required credentials
  //     case AuthorizationStatus.error:
  //       print("Sign in failed: ${result.error.localizedDescription}");
  //       print('sonu failed');

  //       break;
  //     case AuthorizationStatus.cancelled:
  //       print('User cancelled');
  //       print('sonu cancelled');
  //       break;
  //     default:
  //       throw UnimplementedError();
  //   }
  // }
}
// }

class _Social extends StatelessWidget {
  const _Social({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
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
                    // onGoogleBtnPress();
                    BlocProvider.of<LoginBloc>(context)
                        .add(SignInWithGooglePressed());
                  }),
              SpaceW12(),
              SocialButton(
                  width: width,
                  title: StringConst.sentence.FACEBOOK,
                  icon: ImagePath.FACEBOOK_ICON,
                  onPressed: () {
                    // initiateFacebookLogin();
                    BlocProvider.of<LoginBloc>(context).add(LoginToFacebook());
                  }),
            ],
          ),
        );
      },
    );
  }
}

class CreateAccountText extends StatelessWidget {
  const CreateAccountText({
    Key key,
    @required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ExtendedNavigator.root.push(Routes.signupScreen);
      },
      child: Container(
        padding: EdgeInsets.only(
          bottom: Sizes.PADDING_20, // space between underline and text
        ),
        child: Center(
          child: RichText(
            text: TextSpan(
              text: StringConst.sentence.NEW_HERE,
              style: theme.textTheme.bodyText2.copyWith(
                color: AppColors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: StringConst.sentence.CREATE_ACCOUNT,
                  style: theme.textTheme.subtitle2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  TextEditingController controller;

  _EmailInput({
    Key key,
    this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final textController = TextEditingController(text: state.email.value);
        textController.selection = TextSelection.fromPosition(
            TextPosition(offset: textController.text.length));

        return Center(
          child: AuthTextFormField(
            controller: textController,
            key: const Key('loginForm_emailInput_textField'),
            hintText: StringConst.label.EMAIL,
            prefixIcon: ImagePath.EMAIL_ICON,
            prefixIconHeight: Sizes.ICON_SIZE_18,
            onChanged: (email) => {
              print("username>> " + state.username.value),
              // controller.text="",
              context.read<LoginBloc>().add(LoginEmailChanged(email))
            },
            errorText: state.email.value == ""
                ? null
                : state.email.error == EmailValidationError.invalid
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

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.username != current.username ||
          previous.country_code != current.country_code,
      builder: (context, state) {
        final textController =
            TextEditingController(text: state.username.value);
        textController.selection = TextSelection.fromPosition(
            TextPosition(offset: textController.text.length));

        //print('country_code-----------' + state.country_code.toString());
        return Center(
          child: PhoneCardTextFormField(
            controller: textController,

// initialValue: state.username.value,
            key: const Key('SignUpForm_PhoneNumberInput_textField'),
            hintText: StringConst.label.MOBILE_NUMBER,
            prefixIcon: ImagePath.INDIA_FLAG_ICON,
            hasPrefixIconColor: false,
            prefixIconHeight: Sizes.ICON_SIZE_14,
            keyboardType: TextInputType.phone,
            onChangedC: (country) => {
              //controller.text="",
              print("email>> " + state.username.value),
              context.read<LoginBloc>().add(LoginCodeChanged(country.phoneCode))
            },
            country_code: state.country_code.value,
            onChanged: (username) => context
                .read<LoginBloc>()
                .add(LoginmobileChanged(username, '', '')),
            errorText: state.username.value == ""
                ? null
                : state.username.invalid
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
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        final textController =
            TextEditingController(text: state.password.value);
        textController.selection = TextSelection.fromPosition(
            TextPosition(offset: textController.text.length));

        return Center(
          child: AuthTextFormField(
            controller: textController,
            key: const Key('loginForm_passwordInput_textField'),
            hintText: StringConst.label.PASSWORD,
            prefixIcon: ImagePath.LOCK_ICON,
            prefixIconHeight: Sizes.ICON_SIZE_18,
            obscured: true,
            onChanged: (password) => {
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
            },
            errorText: state.password.value == "" && state.email.value == ""
                ? null
                : state.password.invalid
                    ? StringConst.sentence.EMPTY_PASSWORD
                    : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const AppLoading()
            : PrimaryButton(
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : () {},
                title: StringConst.sentence.LOG_IN,
                theme: Theme.of(context),
              );
      },
    );
  }
}
