import 'package:auto_route/auto_route.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:care4parents/helper/validation/users.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/screens/edit_profile/profile.dart';
import 'package:care4parents/presentation/screens/edit_profile/view/profile_text_field.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../change_password.dart';

class ChangePasswordScreen extends StatefulWidget {
  // ChangePasswordScreen({this.user});
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // UserEntity _user;

  // _ChangePasswordScreenState(UserEntity user) {
  //   this._user = user;
  // }
  ChangePasswordBloc _changePasswordBloc;

  @override
  void initState() {
    super.initState();
    _changePasswordBloc = getItInstance<ChangePasswordBloc>();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
        child: CustomAppBar(
          title: StringConst.sentence.CHANGE_PASSWORD,
          leading: InkWell(
              onTap: () => ExtendedNavigator.root.pop(),
              child: Icon(Icons.arrow_back_ios)),
          onLeadingTap: () => {},
            trailing: [
              new whatappIconwidget(isHeader:true)

            ],
            hasTrailing: true
        ),
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SpaceH20(),
                Container(
                  height: heightOfScreen * 0.85,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.white,
                        AppColors.white,
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(Sizes.RADIUS_10),
                    ),
                  ),
                  child: BlocProvider(
                    create: (context) => _changePasswordBloc,
                    child: ChangePasswordForm(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = assignWidth(context: context, fraction: 1.0);
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        print('state ui' + state.toString());
        if (state.status.isSubmissionFailure) {
          failureSnackBar(context);
        }

        if (state.status.isSubmissionSuccess) {
          ExtendedNavigator.root.pop();
        }
      },
      child: Column(
        children: [
          _CurrentPassInput(),
          SpaceH12(),
          _NewPassInput(),
          SpaceH12(),
          _ConfirmPassInput(),
          Spacer(),
          _SubmitButton(),
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
}

class _CurrentPassInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.current_pass != current.current_pass,
      builder: (context, state) {
        return ProfileTextFormField(
          obscured: true,
          key: const Key('changePassForm_nameInput_textField'),
          hintText: StringConst.label.CURRENT_PASSWORD,
          onChanged: (current_pass) => context.read<ChangePasswordBloc>().add(
                ChangePasswordCurrentPassChanged(current_pass),
              ),
          errorText: state.current_pass.invalid
              ? StringConst.sentence.EMPTY_CURRENT_PASS
              : null,
        );
      },
    );
  }
}

class _NewPassInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) => previous.new_pass != current.new_pass,
      builder: (context, state) {
        return ProfileTextFormField(
          obscured: true,
          key: const Key('changePassForm_nameInput_textField'),
          hintText: StringConst.label.NEW_PASSWORD,
          onChanged: (new_pass) => context.read<ChangePasswordBloc>().add(
                ChangePasswordNewPassChanged(new_pass),
              ),
          errorText: state.new_pass.invalid
              ? StringConst.sentence.EMPTY_NEW_PASS
              : null,
        );
      },
    );
  }
}

class _ConfirmPassInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.confirm_pass != current.confirm_pass,
      builder: (context, state) {
        return ProfileTextFormField(
          obscured: true,
          key: const Key('changePassForm_nameInput_textField'),
          hintText: StringConst.label.CONFIRM_PASSWORD,
          onChanged: (confirm_pass) => context.read<ChangePasswordBloc>().add(
                ChangePasswordConfirmPassChanged(confirm_pass),
              ),
          errorText: state.confirm_pass.invalid
              ? StringConst.sentence.EMPTY_CONFIRM_PASS
              : null,
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      // buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const AppLoading()
            : Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_20, vertical: Sizes.dimen_20),
                child: PrimaryButton(
                  onPressed: () {
                    context
                        .read<ChangePasswordBloc>()
                        .add(const ChangePasswordSubmitted());
                  },
                  // : () {},
                  title: CommonButtons.SAVE,
                  theme: Theme.of(context),
                ),
              );
      },
    );
  }
}
