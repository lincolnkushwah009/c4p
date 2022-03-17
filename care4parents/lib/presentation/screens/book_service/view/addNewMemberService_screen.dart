import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/book_appointment/bloc/book_appointment_bloc.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/booking_text_form_field.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/custom_snackbar.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:formz/formz.dart';

class AddNewMemberBookService extends StatefulWidget {
  final int appointment_id;
  final String  specialist,
  date,
  remark,
  phone;

  AddNewMemberBookService({this.appointment_id,this.specialist,this.date,this.remark,this.phone}) : super();

  @override
  _AppointmentPaymentState createState() => _AppointmentPaymentState();
}

class _AppointmentPaymentState extends State<AddNewMemberBookService> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  BookAppointmentBloc bookAppointmentBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookAppointmentBloc = getItInstance<BookAppointmentBloc>();
    bookAppointmentBloc.add(AppointmentSpecialistChanged(widget.specialist));
    bookAppointmentBloc.add(AppointmentPhoneChanged(widget.phone));
    bookAppointmentBloc.add(AppointmentRemarkChanged(widget.remark));
    bookAppointmentBloc.add(AppointmentDateChanged(widget.date));
    print("  service specialist>>widget  " + widget.specialist.toString());
    print("  service date>> widget  " + widget.date.toString());
    print("  service phone>>widget  " + widget.phone.toString());
    print("  service remark>>widget   " + widget.remark.toString());
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
        listener: (context, state) async{
          if (state.status.isSubmissionFailure) {
            SnackBarWidgets.buildErrorSnackbar(context, 'add new member failed');
          }
          int appointment_id = await SharedPreferenceHelper.getAppointmentIdPref();
          print('appointment_id>>>>>  '+appointment_id.toString());
          if (state.status.isSubmissionSuccess) {
            print('isSubmissionSuccess');


            ExtendedNavigator.root
                .push(Routes.appointmentPayment,
                arguments: AppointmentPaymentArguments(appointment_id: 1))
                .then(onGoBack);
          }else if(state.memberId!=null&&appointment_id==null){
            print('memberId>>>>>  '+state.memberId.toString());
            context
                .read<BookAppointmentBloc>()
                .add(BookAppointmentSubmitted());
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
                trailing: [

                  new whatappIconwidget(isHeader:true)
                ],
                hasTrailing: true),
          ),
          body: SingleChildScrollView(
          child:Container(
            margin: EdgeInsets.only(top: 40,left:widthOfScreen * 0.02,right:widthOfScreen * 0.02 ),
            child: Container(
                padding: EdgeInsets.all(0.0),

                height: heightOfScreen * 0.92,

                child: BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
                    builder: (context, state) {
                  if (state.fees == null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SpaceH12(),
                          _RemarkInput(),
                          SpaceH12(),
                          _PhoneInput(),
                          SpaceH12(),
                          _DateInput(),
                          SpaceH12(),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: Sizes.MARGIN_8,
                                  left: Sizes.MARGIN_20,
                                  right: Sizes.MARGIN_16),
                              child: Text(
                                StringConst.label.GENDER,
                                style: titleTextStyle,
                              ),
                            ),
                          ),
                          _MemberDropDown(),
                          SpaceH12(),
                          _AddressInput(),
                          SpaceH12(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: _SubmitButton(members:[]),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else
                    return Container();
                })),
          ),
        ),
      ),),
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
            onPressed: state.status.isValidated && ((state.member != null&&members.length>0)||(state.member == null&&members.length==0))
                ? () {
              context
                  .read<BookAppointmentBloc>()
                  .add(NewMemberSubmitted());
            }
                : () {
              context
                  .read<BookAppointmentBloc>()
                  .add(NewMemberSubmitted());

              // print("name>> " + state.name.value);
              //
              // print("phone>> " + state.phone.value);
              // print("dateMember>> " + state.dateMember.value);
              //
              //
              // print("address>> " + state.address.value);
              //print("service>> " + state.service.toString());
              print('dateMember ==========' + state.dateMember.toString());
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

class _DateInput extends StatefulWidget {
  @override
  __DateInputState createState() => __DateInputState();
}

class __DateInputState extends State<_DateInput> {
  var _controller = TextEditingController(text: '');
  DateFormat dFormat = DateFormat('yyyy-MM-dd');

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });

    print("sonu   njjjklkj jjm");
      context.read<BookAppointmentBloc>().add(
        ServiceDateChanged(dFormat.format(picked)),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      buildWhen: (previous, current) => previous.dateMember != current.dateMember,
      builder: (context, state) {
        DateTime date = DateTime.now();
        final text = state.dateMember.value != ''
            ? state.dateMember.value.toString()
            : dFormat.format(date);
        // print('text======${state.date.value.toString()}');
        _controller = TextEditingController(
          text: text ?? "",
          // selection: TextSelection.collapsed(offset: text?.length ?? 0),
        );

        return BookingTextFormField(
            controller: _controller,
            key: const Key('appointmentForm_dateInput_textField'),
            hintText: StringConst.label.DATE_OF_BIRTHDAY,
            fieldTitle: StringConst.label.DATE_OF_BIRTHDAY,
            prefixIconHeight: Sizes.ICON_SIZE_18,
            onChanged: (sp) => {},
            errorText: null,
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              _selectDate(context);
              // await ExtendedNavigator.root.push(Routes.calenderScreen).then(
              //       (date_time) => context.read<UploadReportBloc>().add(
              //             ServiceDateChanged(date_time),
              //           ),
              //     );
            });
      },
    );
  }
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
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        _controller.text =
        state.name.value != null ? state.name.value.toString() : '';

        return BookingTextFormField(
          // controller: _controller,
          key: const Key('appointmentForm_remarkInput_textField'),
          hintText: StringConst.label.MEMBER_NAME,
          fieldTitle: StringConst.label.MEMBER_NAME,

          prefixIconHeight: Sizes.ICON_SIZE_18,
          onChanged: (sp) => {
            context.read<BookAppointmentBloc>().add(
              NewMemberNameChanged(sp),
            )
          },
          errorText: null,
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
              NewMemberAddressChanged(sp),
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
      buildWhen: (previous, current) => previous.newMemberphone != current.newMemberphone,
      builder: (context, state) {
        final text =
        state.newMemberphone.value != null ? state.newMemberphone.value.toString() : '';
        final textController = TextEditingController(text: text);
        textController.selection = TextSelection.fromPosition(TextPosition(offset: textController.text.length));
        return BookingTextFormField(
            controller: _controller,
            // initialValue:  _controller.text,
            key: const Key('appointmentForm_phoneInput_textField'),
            hintText: StringConst.label.MEMBER_PHONE,
            fieldTitle: StringConst.label.MEMBER_PHONE,
            prefixIconHeight: Sizes.ICON_SIZE_18,
            // keyboardType: TextInputType.phone,
            onChanged: (sp) => {
              context.read<BookAppointmentBloc>().add(
                NewMemberPhoneChanged(sp),
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

class _MemberDropDown extends StatefulWidget {
  @override
  __MemberDropDownState createState() => __MemberDropDownState();
}
class ServiceType {
  const ServiceType(this.id, this.service);

  final int id;
  final String service;
}
class __MemberDropDownState extends State<_MemberDropDown> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = assignWidth(context: context, fraction: 1.0);
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
        buildWhen: (previous, current) => previous.service != current.service,
        builder: (context, state) {
          // print('state' + state.service.id.toString());
          return Container(
            width: width * 0.92,
            padding: const EdgeInsets.only(left: 5.0, right:5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.grey10,
              border: Border.all(color: AppColors.white),
              // boxShadow: [Shadows.bgCardShadow],
            ),
            child: Row(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                      elevation: 10,
                      dropdownColor: AppColors.grey10,
                      value: state.service != null
                          ? state.service
                          : const ServiceType(3, 'Male'),
                      items: [
                        const ServiceType(3, 'Male'),
                        const ServiceType(2, 'Female'),

                      ].map<DropdownMenuItem<ServiceType>>(
                              (ServiceType serviceType) {
                            // print(serviceType.service.t);
                            // print('serviceType.service' + serviceType.service);
                            return DropdownMenuItem<ServiceType>(
                              value: serviceType,
                              child: Container(
                                  child: Text((serviceType == null ||
                                      serviceType.service == null)
                                      ? '----'
                                      : serviceType.service),
                                  width: width * 0.8),
                            );
                          }).toList(),
                      // onChanged: (ServiceType serviceType) async {
                      //   // FocusScope.of(context).requestFocus(FocusNode());
                      //
                      //   context.read<BookAppointmentBloc>().add(
                      //     ServiceChanged(serviceType),
                      //   );
                      // },
                      hint: Text(StringConst.label.MEMBER_NAME,
                          style: theme.textTheme.bodyText2.copyWith(
                            color: AppColors.black,
                          )),
                      style: theme.textTheme.bodyText2.copyWith(
                        color: AppColors.black,
                      ),
                      icon: Icon(Feather.chevron_down,
                          color: AppColors.primaryColor)),
                ),
              ],
            ),
          );
        });
  }
}







