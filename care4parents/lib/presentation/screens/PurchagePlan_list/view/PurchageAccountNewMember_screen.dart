import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/book_appointment/bloc/book_appointment_bloc.dart';
import 'package:care4parents/presentation/screens/signup/models/models.dart';
import 'package:care4parents/presentation/screens/upload_report/view/upload_screen.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/auth/auth_text_form_field.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/booking_text_form_field.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/custom_snackbar.dart';
import 'package:care4parents/presentation/widgets/loading_dialog.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:formz/formz.dart';

class PurchageAccountNewMember extends StatefulWidget {

  final String  type;
  final String name,dateMember;
  ServiceType gender,relation;
  PurchageAccountNewMember(
      {
      this.type,this.name,this.dateMember,this.gender,this.relation})
      : super();

  @override
  _AppointmentPaymentState createState() => _AppointmentPaymentState();
}

class _AppointmentPaymentState extends State<PurchageAccountNewMember> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  BookAppointmentBloc bookAppointmentBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookAppointmentBloc = getItInstance<BookAppointmentBloc>();


    print("  type type>>type   " + widget.type.toString());
    print("  type name>>name   " + widget.name.toString());
    print("  type type>>dateMember   " + widget.dateMember.toString());
    print("  type type>>relation   " + widget.relation.toString());
    print("  type type>>gender   " + widget.gender.toString());

    bookAppointmentBloc.add(NewMemberNameChanged(widget.name));
    bookAppointmentBloc.add(ServiceDateChanged(widget.dateMember));
    bookAppointmentBloc.add(RelationChanged(widget.relation));
    bookAppointmentBloc.add(ServiceChanged(widget.gender));
  }

  Future<bool> onGoBack(dynamic value) async {
    ExtendedNavigator.root.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    ThemeData theme = Theme.of(context);
    TextStyle titleTextStyle =
        theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => bookAppointmentBloc,
        ),
      ],
      child: BlocListener<BookAppointmentBloc, BookAppointmentState>(
        listener: (context, state) async {
          if (state.status.isSubmissionFailure) {
            SnackBarWidgets.buildErrorSnackbar(
                context, 'add new member failed');
          }
          print('ddd isSubmissionSuccess');
          if (state.status.isSubmissionSuccess) {
            print('isSubmissionSuccess');

           // ExtendedNavigator.root.pop();

          }


        },
        child: Scaffold(
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
            child: CustomAppBar(
                title: CommonButtons.ADD_FAMILY_MEMBER,
                leading: InkWell(
                    onTap: () => {ExtendedNavigator.root.pop()},
                    child: Icon(Icons.arrow_back_ios_outlined)),
                trailing: [new whatappIconwidget(isHeader: true)],
                hasTrailing: true),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  top: 40,
                  left: widthOfScreen * 0.02,
                  right: widthOfScreen * 0.02),
              child: Container(
                  padding: EdgeInsets.all(0.0),

                  child: BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
                      builder: (context, state) {

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [

                            SpaceH12(),
                            _EmailInput(),

                            SpaceH12(),
                            _AddressInput(),

                            SpaceH12(),
                            _PhoneInput(),

                            SpaceH12(),
                            _ContactPersonInput(),
                            SpaceH12(),
                            _EmergencyPhoneInput(),
                            SpaceH12(),
                            _PincodeInput(),
                            SpaceH12(),
                            _StateInput(),
                            SpaceH12(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: _SubmitButton(
                                    members: [], type: widget.type),
                              ),
                            ),
                          ],
                        ),
                      );

                  })),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactPersonInput extends StatefulWidget {
  @override
  _ContactPersonInputState createState() => _ContactPersonInputState();
}
class _ContactPersonInputState extends State<_ContactPersonInput> {
  var _controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      buildWhen: (previous, current) => previous.contactPerson
          != current.contactPerson,
      builder: (context, state) {
        _controller.text =
        state.contactPerson.value != null ? state.contactPerson.value.toString() : '';

        return BookingTextFormField(
          // controller: _controller,
          key: const Key('appointmentForm_remarkInput_textField'),
          hintText: StringConst.label.EMERGENCY_CONTACT_PERSON,
          fieldTitle: StringConst.label.EMERGENCY_CONTACT_PERSON,

          prefixIconHeight: Sizes.ICON_SIZE_18,
          onChanged: (sp) => {
            context.read<BookAppointmentBloc>().add(
              NewMemberContactPersonChanged(sp),
            )
          },
          errorText: null,
        );
      },
    );
  }
}



class _EmailInput extends StatefulWidget {
  @override
  __EmailInputState createState() => __EmailInputState();
}
class __EmailInputState extends State<_EmailInput> {
  var _controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        _controller.text =
        state.email.value != null ? state.email.value.toString() : '';

        return BookingTextFormField(
          // controller: _controller,
          key: const Key('appointmentForm_remarkInput_textField'),
          hintText: StringConst.label.MEMBER_EMAIL,
          fieldTitle: StringConst.label.MEMBER_EMAIL,
          keyboardType: TextInputType.emailAddress,
          prefixIconHeight: Sizes.ICON_SIZE_18,
          onChanged: (sp) => {
            context.read<BookAppointmentBloc>().add(
              NewMemberEmailChanged(sp),
            )
          },
          errorText: null,
        );
      },
    );
  }
}


class _StateInput extends StatefulWidget {
  @override
  __StateInputState createState() => __StateInputState();
}
class __StateInputState extends State<_StateInput> {
  var _controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      buildWhen: (previous, current) => previous.state != current.state,
      builder: (context, state) {
        _controller.text =
        state.state.value != null ? state.state.value.toString() : '';

        return BookingTextFormField(
          // controller: _controller,
          key: const Key('appointmentForm_remarkInput_textField'),
          hintText: StringConst.label.STATE,
          fieldTitle: StringConst.label.STATE,

          prefixIconHeight: Sizes.ICON_SIZE_18,
          onChanged: (sp) => {
            context.read<BookAppointmentBloc>().add(
              NewMemberStateChanged(sp),
            )
          },
          errorText: null,
        );
      },
    );
  }
}




class _PincodeInput extends StatefulWidget {
  @override
  ___PincodeInputState createState() => ___PincodeInputState();
}
class ___PincodeInputState extends State<_PincodeInput> {
  var _controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      buildWhen: (previous, current) => previous.pincode != current.pincode,
      builder: (context, state) {
        _controller.text =
        state.pincode.value != null ? state.pincode.value.toString() : '';

        return BookingTextFormField(
          // controller: _controller,
          key: const Key('appointmentForm_remarkInput_textField'),
          hintText: StringConst.label.PINCODE,
          fieldTitle: StringConst.label.PINCODE,
          keyboardType: TextInputType.number,
          prefixIconHeight: Sizes.ICON_SIZE_18,
          onChanged: (sp) => {
            context.read<BookAppointmentBloc>().add(
              NewMemberPincodeChanged(sp),
            )
          },
          errorText: null,
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final List<FamilyMainResult> members;
  String type;
  _SubmitButton({Key key, this.members, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const AppLoading()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: PrimaryButton(
                  onPressed: state.statusPurchageTwo.isValidated
                      ? () {

                            print("bookAppintment>succedsss> " + state.email.value);

                            print("bookAppintment>address> " + state.address.value);
                            print("bookAppintment>newMemberphone> " + state.newMemberphone.value);
                            print("bookAppintment>contactPerson> " + state.contactPerson.value);
                            print("bookAppintment>newMemberEmergenncyphone> " + state.newMemberEmergenncyphone.value);

                            print("bookAppintment>state> " + state.state.value);
                            print("bookAppintment>pincode> " + state.pincode.value);


                            context
                                .read<BookAppointmentBloc>()
                                .add(PurchagePlanMemberSubmitted());


                        }
                      : () {
                    print("bookAppintment>sssss> " + state.email.value);

                    print("bookAppintment>address> " + state.address.value);
                    print("bookAppintment>newMemberphone> " + state.newMemberphone.value);
                    print("bookAppintment>contactPerson> " + state.contactPerson.value);
                    print("bookAppintment>newMemberEmergenncyphone> " + state.newMemberEmergenncyphone.value);

                    print("bookAppintment>state> " + state.state.value);
                    print("bookAppintment>pincode> " + state.pincode.value);


                          SnackBarWidgets.buildErrorSnackbar(
                              context, StringConst.sentence.PEAF);
                        },
                  title:  CommonButtons.SAVE,
                  theme: Theme.of(context),
                ),
              );
      },
    );
  }
}




class _AddressInput extends StatefulWidget {
  @override
  __AddressInputState createState() => __AddressInputState();
}

class __AddressInputState extends State<_AddressInput> {
  var _controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        _controller.text =
            state.address.value != null ? state.address.value.toString() : '';

        return BookingTextFormField(
          // controller: _controller,
          key: const Key('appointmentForm_remarkInput_textField'),
          hintText: StringConst.label.MEMBER_ADDRESS,
          fieldTitle: StringConst.label.MEMBER_ADDRESS,

          prefixIconHeight: Sizes.ICON_SIZE_18,
          onChanged: (sp) => {
            context.read<BookAppointmentBloc>().add(
              PurchageNewMemberAddressChanged(sp),
                )
          },
          errorText: null,
        );
      },
    );
  }
}

class _EmergencyPhoneInput extends StatefulWidget {
  @override
  _EmergencyPhoneInputState createState() => _EmergencyPhoneInputState();
}

class _EmergencyPhoneInputState extends State<_EmergencyPhoneInput> {
  var _controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      buildWhen: (previous, current) =>
      previous.newMemberEmergenncyphone != current.newMemberEmergenncyphone,
      builder: (context, state) {
        final text = state.newMemberEmergenncyphone.value != null
            ? state.newMemberEmergenncyphone.value.toString()
            : '';
        final textController = TextEditingController(text: text);
        textController.selection = TextSelection.fromPosition(
            TextPosition(offset: textController.text.length));
        return BookingTextFormField(
            controller: _controller,
            // initialValue:  _controller.text,
            key: const Key('appointmentForm_phoneInput_textField'),
            hintText: StringConst.label.EMERGENCY_CONTACT_NO,
            fieldTitle: StringConst.label.EMERGENCY_CONTACT_NO,
            prefixIconHeight: Sizes.ICON_SIZE_18,
            keyboardType: TextInputType.phone,
            onChanged: (sp) => {
              context.read<BookAppointmentBloc>().add(
                NewMemberEmergenncyphoneChanged(sp),
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

class _PhoneInput extends StatefulWidget {
  @override
  __PhoneInputState createState() => __PhoneInputState();
}

class __PhoneInputState extends State<_PhoneInput> {
  var _controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      buildWhen: (previous, current) =>
          previous.newMemberphone != current.newMemberphone,
      builder: (context, state) {
        final text = state.newMemberphone.value != null
            ? state.newMemberphone.value.toString()
            : '';
        final textController = TextEditingController(text: text);
        textController.selection = TextSelection.fromPosition(
            TextPosition(offset: textController.text.length));
        return BookingTextFormField(
            controller: _controller,
            // initialValue:  _controller.text,
            key: const Key('appointmentForm_phoneInput_textField'),
            hintText: StringConst.label.MEMBER_PHONE,
            fieldTitle: StringConst.label.MEMBER_PHONE,
            prefixIconHeight: Sizes.ICON_SIZE_18,
             keyboardType: TextInputType.phone,
            onChanged: (sp) => {
                  context.read<BookAppointmentBloc>().add(
                    PurchageNewMemberPhoneChanged(sp),
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

