import 'package:auto_route/auto_route.dart';
import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:care4parents/helper/validation/users.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/screens/edit_profile/profile.dart';
import 'package:care4parents/presentation/screens/edit_profile/view/profile_text_field.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class EditProfileForm extends StatelessWidget {
  final UserEntity user;
  EditProfileForm({this.user});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = assignWidth(context: context, fraction: 1.0);
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        print('emailVerifyStatus ui>>   ' +
            state.emailVerifyStatus.value.toString());
        if (state.status.isSubmissionFailure) {
          failureSnackBar(context);
        }

        if (state.status.isSubmissionSuccess &&
            state.emailVerifyStatus.value == "1") {
          failureSnackBar(context,
              message: "We have sent an email to verify your email address!");
        } else if (state.status.isSubmissionSuccess &&
            state.emailVerifyStatus.value == "2") {
          ExtendedNavigator.root.pop();
        }
      },
      child: Column(
        children: [
          _NameInput(name: user.name),
          SpaceH12(),
          _EmailInput(
              email: user.email != null ? user.email : "",
              confirmed: user.confirmed),
          SpaceH12(),
          _PhoneNumberInput(phone_number: user.phone_number),
          SpaceH12(),
          _CountryInput(country: user.country),
          SpaceH12(),
          _AddressInput(address: user.address),
          SpaceH12(),
          _SubmitButton(),
          SpaceH12(),
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

class _EmailInput extends StatelessWidget {
  final String email;
  final bool confirmed;
  _EmailInput({this.email, this.confirmed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        ThemeData theme = Theme.of(context);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: ProfileTextFormField(
              key: const Key('editProfileForm_emailInput_textField'),
              initialValue: email,
              fieldTitle: StringConst.label.EMAIL,
              hintText: StringConst.label.EMAIL,
              onChanged: (email) => context
                  .read<EditProfileBloc>()
                  .add(EditProfileEmailChanged(email)),
              errorText: state.email.error == EmailValidationError.invalid
                  ? StringConst.sentence.INVALID_EMAIL
                  : state.email.invalid
                      ? StringConst.sentence.EMPTY_EMAIL
                      : null,
              keyboardType: TextInputType.emailAddress,
            )),
            !confirmed
                ? InkWell(
                    onTap: () {
                      context
                          .read<EditProfileBloc>()
                          .add(EditProfileEmailVerifyChanged("1"));
                      context
                          .read<EditProfileBloc>()
                          .add(EmailVerifySubmitted());
                      // _onLogout();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 30, right: 15),
                      padding: EdgeInsets.only(left: 5, right: 5),
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: Colors.red,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(CommonButtons.VERIFY,
                              style: theme.textTheme.blueHeadline4
                                  .copyWith(color: Colors.white))
                        ],
                      ),
                    ))
                : new Container(),
          ],
        );
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  final String phone_number;
  _PhoneNumberInput({this.phone_number});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) =>
          previous.phone_number != current.phone_number,
      builder: (context, state) {
        return ProfileTextFormField(
          key: const Key('editProfileForm_phoneInput_textField'),
          initialValue: phone_number,
          fieldTitle: StringConst.label.PHONE_NUMBER,
          hintText: StringConst.label.PHONE_NUMBER,
          onChanged: (phone_number) => context.read<EditProfileBloc>().add(
                EditProfilePhoneNumberChanged(phone_number),
              ),
//          errorText:
//              state.phone_number.error == PhoneNumberValidationError.invalid
//                  ? StringConst.sentence.INVALID_PHONE_NUMBER
//                  : state.phone_number.invalid
//                      ? StringConst.sentence.EMPTY_MOBILE
//                      : null,
          keyboardType: TextInputType.phone,
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  final String name;
  _NameInput({this.name});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return ProfileTextFormField(
          key: const Key('editProfileForm_nameInput_textField'),
          initialValue: name,
          fieldTitle: StringConst.label.NAME,
          hintText: StringConst.label.NAME,
          onChanged: (name) => context.read<EditProfileBloc>().add(
                EditProfileNameChanged(name),
              ),
          errorText:
              state.name.invalid ? StringConst.sentence.EMPTY_NAME : null,
        );
      },
    );
  }
}

class _CountryInput extends StatelessWidget {
  final String country;
  _CountryInput({this.country});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.country != current.country,
      builder: (context, state) {
        return ProfileTextFormField(
          key: const Key('editProfileForm_nameInput_textField'),
          initialValue: country,
          fieldTitle: StringConst.label.CURRENT_COUNTRY,
          hintText: StringConst.label.CURRENT_COUNTRY,
          onChanged: (country) => context.read<EditProfileBloc>().add(
                EditProfileCountry(country),
              ),
          // errorText:
          //     state.country.invalid ? StringConst.sentence.EMPTY_COUNTRY : null,
        );
      },
    );
  }
}

class _AddressInput extends StatelessWidget {
  final String address;
  _AddressInput({this.address});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return ProfileTextFormField(
          key: const Key('editProfileForm_addressInput_textField'),
          initialValue: address,
          fieldTitle: StringConst.label.CURRENT_ADDRESS,
          hintText: StringConst.label.CURRENT_ADDRESS,
          onChanged: (address) => context.read<EditProfileBloc>().add(
                EditProfileAddress(address),
              ),
          // errorText: (state.address.invalid && !state.status.isValidated)
          //     ? StringConst.sentence.EMPTY_ADDRESS
          //     : null,
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      // buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return
            // state.status.isSubmissionInProgress
            //     ? const AppLoading()
            //     :
            Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.dimen_20, vertical: Sizes.dimen_20),
          child: PrimaryButton(
            onPressed: () {
              print('submit');
              context
                  .read<EditProfileBloc>()
                  .add(EditProfileEmailVerifyChanged("0"));
              context.read<EditProfileBloc>().add(const EditProfileSubmitted());
            },
            title: CommonButtons.SUBMIT,
            theme: Theme.of(context),
          ),
        );
      },
    );
  }
}
