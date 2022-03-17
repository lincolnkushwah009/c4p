import 'package:auto_route/auto_route.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/presentation/screens/signup/bloc/signup_bloc.dart';
import 'package:care4parents/presentation/screens/signup/view/signup_form.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/auth/auth_app_bar.dart';
import 'package:care4parents/presentation/widgets/auth/auth_text_form_field.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/auth/social_button.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:flutter/material.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupBloc _signUpBloc;

  @override
  void initState() {
    super.initState();
    _signUpBloc = getItInstance<SignupBloc>();
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AuthAppBar(),
            BlocProvider(
              create: (context) => _signUpBloc,
              child: SignUpForm(),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: new whatappIconwidget(isHeader:false),
    );
  }

  Widget _signUpForm(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = assignWidth(context: context, fraction: 1.0);

    return Column(
      children: [
        SpaceH60(),
        Text(
          StringConst.sentence.GYR,
          style: theme.textTheme.subtitle1.copyWith(
            color: AppColors.blackShade3,
          ),
        ),
        SpaceH20(),
        SpaceH20(),
        AuthTextFormField(
            hintText: StringConst.label.NAME,
            prefixIcon: ImagePath.EMAIL_ICON,
            prefixIconHeight: Sizes.ICON_SIZE_14),
        SpaceH20(),
        AuthTextFormField(
            hintText: StringConst.label.EMAIL,
            prefixIcon: ImagePath.EMAIL_ICON,
            prefixIconHeight: Sizes.ICON_SIZE_14,
            keyboardType: TextInputType.emailAddress),
        SpaceH20(),
        AuthTextFormField(
            hintText: StringConst.label.MOBILE_NUMBER,
            prefixIcon: ImagePath.INDIA_FLAG_ICON,
            hasPrefixIconColor: false,
            prefixIconHeight: Sizes.ICON_SIZE_14,
            keyboardType: TextInputType.phone),
        SpaceH20(),
        AuthTextFormField(
          hintText: StringConst.label.PASSWORD,
          prefixIcon: ImagePath.LOCK_ICON,
          prefixIconHeight: Sizes.ICON_SIZE_18,
          obscured: true,
        ),
        Spacer(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_24),
          child: _SignUpButton(),
        ),
        SpaceH48(),
      ],
    );
  }

  void onSubmitPress() {
    ExtendedNavigator.root.push(Routes.otpScreen);
  }
}

class _SignUpButton extends StatelessWidget {
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
                        context.read<SignupBloc>().add(const SignupSubmitted());
                      }
                    : () {},
                title: CommonButtons.NEXT,
                theme: Theme.of(context),
              );
      },
    );
  }
}
