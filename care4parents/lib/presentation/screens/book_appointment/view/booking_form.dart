import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/book_appointment/bloc/book_appointment_bloc.dart';
import 'package:care4parents/presentation/screens/book_appointment/view/search_specialist.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/custom_snackbar.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pedantic/pedantic.dart';
import 'package:formz/formz.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../widgets/booking_text_form_field.dart';

class BookingForm extends StatelessWidget {
  final List<FamilyMainResult> members;
  const BookingForm({Key key, this.members}) : super(key: key);

  Future<bool> onGoBack(dynamic value) async {
    ExtendedNavigator.root.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle titleTextStyle =
        theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700);
    TextStyle formTextStyle = theme.textTheme.subtitle1;
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return BlocListener<BookAppointmentBloc, BookAppointmentState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            SnackBarWidgets.buildErrorSnackbar(
                context, StringConst.sentence.APPOINTMENT_FAILED);
          }
          if (state.status.isSubmissionSuccess) {
            if (state.member == null) {
              ExtendedNavigator.root.push(Routes.addNewMemberScreen,
                  arguments: AddNewMemberArguments(
                      appointment_id: 1,
                      specialist: state.specialist.value,
                      date: state.date.value,
                      remark: state.remark.value,
                      phone: state.phone.value,
                      type: 'bookAppointment'));
            } else {
              ExtendedNavigator.root.push(Routes.appointmentPayment,
                  arguments: AppointmentPaymentArguments(
                      appointment_id: 1, type: 'bookAppointment'));
            }

            // showDialog(
            //     context: context,
            //     barrierDismissible: false,
            //     builder: (context) => thanksDialog);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpaceH12(),
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: Container(
            //     margin: EdgeInsets.only(
            //         bottom: Sizes.MARGIN_8,
            //         left: Sizes.MARGIN_20,
            //         right: Sizes.MARGIN_16),
            //     child: Text(
            //       StringConst.label.MEMBER_NAME,
            //       style: titleTextStyle,
            //     ),
            //   ),
            // ),
            // _MemberDropDown(),

            SpaceH8(),
            members != null && members.length > 0
                ? _MembersInput()
                : new Container(),
            SpaceH8(),
            _SpecialitiesInput(),
            SpaceH8(),
            _DateInput(),

            members != null && members.length > 0 ? SpaceH8() : new Container(),
            members != null && members.length > 0
                ? _PhoneInput()
                : new Container(),

            SpaceH8(),
            _RemarkInput(),
            SpaceH8(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _SubmitButton(
                  members: members,
                ),
              ),
            ),
          ],
        ));
  }
}

Widget formFieldTitle({@required String fieldTitle, TextStyle textStyle}) {
  return Container(
    margin: EdgeInsets.only(bottom: Sizes.MARGIN_4),
    padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_26),
    child: Text(fieldTitle, textAlign: TextAlign.start, style: textStyle),
  );
}

class _RemarkInput extends StatefulWidget {
  @override
  __RemarkInputState createState() => __RemarkInputState();
}

class __RemarkInputState extends State<_RemarkInput> {
  var _controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      buildWhen: (previous, current) => previous.remark != current.remark,
      builder: (context, state) {
        _controller.text =
            state.remark.value != null ? state.remark.value.toString() : '';

        return BookingTextFormField(
          // controller: _controller,
          key: const Key('appointmentForm_remarkInput_textField'),
          hintText: StringConst.label.REMARK,
          fieldTitle: StringConst.label.REMARK,

          prefixIconHeight: Sizes.ICON_SIZE_18,
          onChanged: (sp) => {
            context.read<BookAppointmentBloc>().add(
                  AppointmentRemarkChanged(sp),
                )
          },
          errorText: null,
        );
      },
    );
  }
}

class _PhoneInput extends StatefulWidget {
  @override
  __PhoneInputState createState() => __PhoneInputState();
}

class __PhoneInputState extends State<_PhoneInput> {
  var _controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        final text =
            state.phone.value != null ? state.phone.value.toString() : '';
        _controller = TextEditingController.fromValue(
          TextEditingValue(
            text: text ?? "",
            selection: TextSelection.collapsed(offset: text?.length ?? 0),
          ),
        );
        return BookingTextFormField(
            controller: _controller,
            // initialValue:  _controller.text,
            key: const Key('appointmentForm_phoneInput_textField'),
            hintText: StringConst.label.PHONE_NUMBER,
            fieldTitle: StringConst.label.PHONE_NUMBER,
            prefixIconHeight: Sizes.ICON_SIZE_18,
             keyboardType: TextInputType.phone,
            onChanged: (sp) => {
                  context.read<BookAppointmentBloc>().add(
                        AppointmentPhoneChanged(sp),
                      )
                },
            errorText: null
            // onTap: () async {
            //   FocusScope.of(context).requestFocus(FocusNode());

            //   await ExtendedNavigator.root.push(Routes.calenderScreen).then(
            //         (date_time) => context.read<BookAppointmentBloc>().add(
            //               ServiceDateChanged(date_time),
            //             ),
            //       );
            // }
            );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final List<FamilyMainResult> members;
  _SubmitButton({
    Key key,
    this.members,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const AppLoading()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: PrimaryButton(
                  onPressed: state.status.isValidated &&
                          ((state.member != null && members.length > 0) ||
                              (state.member == null && members.length == 0))
                      ? () {
                          context
                              .read<BookAppointmentBloc>()
                              .add(BookAppointmentSubmitted());
                        }
                      : () {
                          print('member ==========' + state.member.toString());
                          print('member list ==========' + members.toString());
                          SnackBarWidgets.buildErrorSnackbar(
                              context, StringConst.sentence.PEAF);
                        },
                  title: StringConst.sentence.BOOK_APPOINTMENT,
                  theme: Theme.of(context),
                ),
              );
      },
    );
  }
}

class _MembersInput extends StatefulWidget {
  @override
  __MembersInputState createState() => __MembersInputState();
}

class __MembersInputState extends State<_MembersInput> {
  var _controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
        buildWhen: (previous, current) => previous.member != current.member,
        builder: (context, state) {
          final text =
              state.member != null && state.member.family_member.name != null
                  ? state.member.family_member.name.capitalize()
                  : '';
          _controller = TextEditingController.fromValue(
            TextEditingValue(
              text: text ?? "",
              selection: TextSelection.collapsed(offset: text?.length ?? 0),
            ),
          );

          print(' state.member>>>>   sonu>>>>>>>>>>>>>>>' +
              state.member.toString());
          return BookingTextFormField(
              key: const Key('appointmentForm_memberpInput_textField'),
              controller: _controller,
              hintText: StringConst.label.MEMBER_NAME,
              fieldTitle: StringConst.label.MEMBER_NAME,
              suffixIcon: Icon(
                Feather.chevron_down,
                color: AppColors.primaryColor,
              ),
              hasSuffixIcon: true,
              prefixIconHeight: Sizes.ICON_SIZE_18,
              onChanged: (sp) => {},
              errorText: null,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());

                await ExtendedNavigator.root
                    .push(Routes.searchMemberScreen)
                    .then(
                      (selectedFamily) =>
                          context.read<BookAppointmentBloc>().add(
                                AppointmentMemberChanged(selectedFamily),
                              ),
                    );
              });
        });
  }
}

class _SpecialitiesInput extends StatefulWidget {
  @override
  __SpecialitiesInputState createState() => __SpecialitiesInputState();
}

class __SpecialitiesInputState extends State<_SpecialitiesInput> {
  var _controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
        buildWhen: (previous, current) =>
            previous.specialist != current.specialist,
        builder: (context, state) {
          final text = state.specialist.value != null
              ? state.specialist.value.toString()
              : '';
          _controller = TextEditingController.fromValue(
            TextEditingValue(
              text: text ?? "",
              selection: TextSelection.collapsed(offset: text?.length ?? 0),
            ),
          );
          return BookingTextFormField(
              key: const Key('appointmentForm_spInput_textField'),
              controller: _controller,
              hintText: StringConst.label.SPECIALITIES,
              fieldTitle: StringConst.label.SPECIALITIES,
              prefixIconHeight: Sizes.ICON_SIZE_18,
              suffixIcon: Icon(
                Feather.chevron_down,
                color: AppColors.primaryColor,
              ),
              hasSuffixIcon: true,
              onChanged: (sp) => {},
              errorText: null,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                await ExtendedNavigator.root.push(Routes.searchScreen).then(
                      (specialist) => context.read<BookAppointmentBloc>().add(
                            AppointmentSpecialistChanged(specialist),
                          ),
                    );
              });
        });
  }
}

class _DateInput extends StatefulWidget {
  @override
  __DateInputState createState() => __DateInputState();
}

class __DateInputState extends State<_DateInput> {
  var _controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      buildWhen: (previous, current) => previous.date != current.date,
      builder: (context, state) {
        final text =
            state.date.value != null ? state.date.value.toString() : '';
        _controller = TextEditingController.fromValue(
          TextEditingValue(
            text: text ?? "",
            selection: TextSelection.collapsed(offset: text?.length ?? 0),
          ),
        );

        return BookingTextFormField(
            controller: _controller,
            key: const Key('appointmentForm_dateInput_textField'),
            hintText: StringConst.label.SELECT_DATE,
            fieldTitle: StringConst.label.SELECT_DATE,
            prefixIconHeight: Sizes.ICON_SIZE_18,
            onChanged: (sp) => {},
            errorText: null,
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              await ExtendedNavigator.root.push(Routes.calenderScreen).then(
                    (date_time) => context.read<BookAppointmentBloc>().add(
                          AppointmentDateChanged(date_time),
                        ),
                  );
            });
      },
    );
  }
}

WillPopScope thanksDialog = WillPopScope(
    onWillPop: () => Future.value(false),
    child: SimpleDialog(
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      children: <Widget>[
        Builder(
          builder: (context) => Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(ImagePath.APPOINTMENT_S),
                        Text('Thanks for Booking!',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(color: AppColors.black)),
                        Text('You booked an appointment with us.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: AppColors.black)),
                      ],
                    )),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        ExtendedNavigator.root.pop();
                        ExtendedNavigator.root.pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(6)),
                          color: AppColors.primaryColor,
                        ),
                        height: 45,
                        child: Center(
                          child: Text('Go To My Appointments'.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w800)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
