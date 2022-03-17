import 'package:auto_route/auto_route.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/auth/auth_app_bar.dart';
import 'package:care4parents/presentation/widgets/auth/auth_text_form_field.dart';
import 'package:care4parents/presentation/widgets/custom_snackbar.dart';
import 'package:care4parents/presentation/widgets/phone_number_input.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../member.dart';

class MemberMobileScreen extends StatefulWidget {
  MemberMobileScreen({Key key}) : super(key: key);

  @override
  _MemberMobileScreenState createState() => _MemberMobileScreenState();
}

class _MemberMobileScreenState extends State<MemberMobileScreen> {
  MemberBloc _memberBloc;

  @override
  void initState() {
    super.initState();
    _memberBloc = getItInstance<MemberBloc>();
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
                  height: heightOfScreen * 0.75,
                  child: BlocProvider(
                    create: (context) => _memberBloc,
                    child: PhoneNumberForm(),
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

class PhoneNumberForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = assignWidth(context: context, fraction: 1.0);
    return BlocListener<MemberBloc, MemberState>(
      listener: (context, state) {
        print('state ui ' + state.phone.value);
        if (state.status.isSubmissionFailure) {
          SnackBarWidgets.buildErrorSnackbar(
              context, StringConst.sentence.LOGIN_FAILED);
        }

        if (state.status.isSubmissionSuccess) {
          ExtendedNavigator.root.push(Routes.memberOtpScreen,
              arguments: MemberOtpScreenArguments(phone: state.phone.value,type:'member'));
        }
      },
      child: Column(
        children: [
          SpaceH20(),
          Text(
            StringConst.sentence.MAO,
            style: theme.textTheme.subtitle1.copyWith(
              color: AppColors.blackShade3,
            ),
          ),
          SpaceH20(),
          _PhoneNumberInput(),
          // SpaceH20(),
          Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_24),
            child: _SignupButton(),
          ),
          SpaceH20(),
        ],
      ),
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberBloc, MemberState>(
      buildWhen: (previous, current) =>
          previous.phone != current.phone ||
          previous.country_code != current.country_code,
      builder: (context, state) {
        print('country_code-----------' + state.country_code.toString());
        return Center(
          child: PhoneCardTextFormField(
            key: const Key('MemberForm_PhoneNumberInput_textField'),
            hintText: StringConst.label.MOBILE_NUMBER,
            prefixIcon: ImagePath.INDIA_FLAG_ICON,
            hasPrefixIconColor: false,
            prefixIconHeight: Sizes.ICON_SIZE_14,
            keyboardType: TextInputType.phone,
            onChangedC: (country) => context
                .read<MemberBloc>()
                .add(MemberCodeChanged(country.phoneCode)),
            country_code: state.country_code.value,
            onChanged: (phone) =>
                context.read<MemberBloc>().add(MemberPhoneNumberChanged(phone,"")),
            errorText:
                state.phone.invalid ? StringConst.sentence.EMPTY_MOBILE : null,
          ),
        );
      },
      // buildWhen: (previous, current) => previous.phone != current.phone,
      // builder: (context, state) {
      //   return AuthTextFormField(
      //     key: const Key('MemberForm_PhoneNumberInput_textField'),
      //     hintText: StringConst.label.MOBILE_NUMBER,
      //     prefixIcon: ImagePath.INDIA_FLAG_ICON,
      //     hasPrefixIconColor: false,
      //     prefixIconHeight: Sizes.ICON_SIZE_14,
      //     keyboardType: TextInputType.phone,
      //     onChanged: (phone) =>
      //         context.read<MemberBloc>().add(MemberPhoneNumberChanged(phone)),
      //     errorText:
      //         state.phone.invalid ? StringConst.sentence.EMPTY_MOBILE : null,
      //   );
      // },
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberBloc, MemberState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const AppLoading()
            : PrimaryButton(
                onPressed: state.status.isValidated
                    ? () {
                        print('phone >>>>' + state.phone.value);
                        context
                            .read<MemberBloc>()
                            .add(const MemberPhoneSubmit());
                      }
                    : () {
                        print('state' + state.phone.value);
                        SnackBarWidgets.buildErrorSnackbar(
                            context, StringConst.sentence.EMPTY_FILED);
                      },
                title: CommonButtons.NEXT,
                theme: Theme.of(context),
              );
      },
    );
  }
}
