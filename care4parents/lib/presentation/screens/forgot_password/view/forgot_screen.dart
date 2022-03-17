import 'package:auto_route/auto_route.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/helper/validation/users.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/auth/auth_app_bar.dart';
import 'package:care4parents/presentation/widgets/auth/auth_text_form_field.dart';
import 'package:care4parents/presentation/widgets/custom_snackbar.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:flutter/material.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../forgot_password.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordBloc _forgotPasswordBloc;

  @override
  void initState() {
    super.initState();
    _forgotPasswordBloc = getItInstance<ForgotPasswordBloc>();
  }

  @override
  Widget build(BuildContext context) {
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
                  height: heightOfScreen * 0.8,
                  child: BlocProvider(
                    create: (context) => _forgotPasswordBloc,
                    child: ForgotForm(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: new whatappIconwidget(isHeader:false),
    );
  }
}

class ForgotForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = assignWidth(context: context, fraction: 1.0);
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        print('state ui' + state.toString());
        if (state.status.isSubmissionFailure) {
          SnackBarWidgets.buildErrorSnackbar(
              context, StringConst.sentence.ERROR_MESSAGE);
        }

        if (state.status.isSubmissionSuccess) {
          SnackBarWidgets.buildErrorSnackbar(
              context, StringConst.sentence.MAIL_CHECK);
          ExtendedNavigator.root
              .pushAndRemoveUntil(Routes.loginScreen, (route) => false);
        }
      },
      child: Column(
        children: [
          SpaceH20(),
          Text(
            StringConst.sentence.FORGOT_PASSWORD_LABEL,
            style: theme.textTheme.headline5.copyWith(
              color: AppColors.black,
            ),
          ),
          SpaceH20(),
          _EmailInput(),
          Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_24),
            child: _SubmitButton(),
          ),
          SpaceH20(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return AuthTextFormField(
          key: const Key('forgotPasswordForm_emailInput_textField'),
          hintText: StringConst.label.EMAIL,
          prefixIcon: ImagePath.EMAIL_ICON,
          prefixIconHeight: Sizes.ICON_SIZE_18,
          onChanged: (email) => context
              .read<ForgotPasswordBloc>()
              .add(ForgotPasswordEmailChanged(email)),
          errorText: state.email.error == EmailValidationError.invalid
              ? StringConst.sentence.INVALID_EMAIL
              : state.email.invalid
                  ? StringConst.sentence.EMPTY_EMAIL
                  : null,
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const AppLoading()
            : PrimaryButton(
                onPressed: state.status.isValidated
                    ? () {
                        context
                            .read<ForgotPasswordBloc>()
                            .add(const ForgotPasswordSubmitted());
                      }
                    : () {},
                title: CommonButtons.SUBMIT,
                theme: Theme.of(context),
              );
      },
    );
  }
}
