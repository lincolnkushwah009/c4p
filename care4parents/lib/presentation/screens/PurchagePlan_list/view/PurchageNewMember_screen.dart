import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/book_appointment/bloc/book_appointment_bloc.dart';
import 'package:care4parents/presentation/screens/book_appointment/view/addNewMember_screen.dart';
import 'package:care4parents/presentation/screens/upload_report/view/upload_screen.dart';
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

class PurchageNewMember extends StatefulWidget {

  final String  type;

  PurchageNewMember(
      {
      this.type})
      : super();

  @override
  _AppointmentPaymentState createState() => _AppointmentPaymentState();
}

class _AppointmentPaymentState extends State<PurchageNewMember> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  BookAppointmentBloc bookAppointmentBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookAppointmentBloc = getItInstance<BookAppointmentBloc>();


    print("  type type>>type   " + widget.type.toString());
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

          if (state.status.isSubmissionSuccess) {
            print('isSubmissionSuccess');

            if( widget.type == "purchagePlan"){
              ExtendedNavigator.root.pop();
            }else{
              ExtendedNavigator.root
                  .push(Routes.appointmentPayment,
                  arguments: AppointmentPaymentArguments(
                      appointment_id: 1, type: widget.type))
                  .then(onGoBack);
            }

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
                  height: heightOfScreen * 0.99,
                  child: BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
                      builder: (context, state) {

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SpaceH12(),
                            _RemarkInput(),
                            // SpaceH12(),
                            // _PhoneInput(),
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
                                  StringConst.label.RELATION,
                                  style: titleTextStyle,
                                ),
                              ),
                            ),
                            _relationDropDown(),
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
                            // SpaceH12(),
                            // _AddressInput(),
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

class _SubmitButton extends StatelessWidget {
  final List<FamilyMainResult> members;
  String type;
  _SubmitButton({Key key, this.members, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(

      builder: (context, state) {
        print("name>ddd> " + state.name.value);
        return state.status.isSubmissionInProgress
            ? const AppLoading()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: PrimaryButton(
                  onPressed: state.statusPurchageOne.isValidated
                      ? () {
                    print("name>> " + state.name.value);
                    print("dateMember>> " + state.dateMember.value);
                    ExtendedNavigator.root
                        .push(Routes.purchageAccountNewMember,
                        arguments:PurchageAccountNewMemberArguments (
                            type:'purchagePlan',

                        gender: state.service,
                          relation: state.relation,
                          dateMember: state.dateMember.value,
                          name: state.name.value
                        ));
                        }
                      : () {
                          print("name>> " + state.name.value);
                          //
                          print("phone>> " + state.phone.value);
                          print("dateMember>> " + state.dateMember.value);

                          print("address>> " + state.address.value);
                          print("service>> " + state.service.toString());
                          print('dateMember ==========' +
                              state.dateMember.toString());
                          print('member list ==========' + members.toString());
                          SnackBarWidgets.buildErrorSnackbar(
                              context, StringConst.sentence.PEAF);
                        },
                  title: CommonButtons.NEXT,
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
        lastDate: selectedDate);
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });


    context.read<BookAppointmentBloc>().add(
      PurchageDateChanged(dFormat.format(picked)),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      buildWhen: (previous, current) =>
          previous.dateMember != current.dateMember,
      builder: (context, state) {
        // DateTime date = DateTime.now();
      //  dFormat.format(date)
        final text = state.dateMember.value != ''
            ? state.dateMember.value.toString()
            : "";
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
print( " state.name.value"+state.name.value);
        return BookingTextFormField(
          // controller: _controller,
          key: const Key('appointmentForm_remarkInput_textField'),
          hintText: StringConst.label.MEMBER_NAME,
          fieldTitle: StringConst.label.MEMBER_NAME,

          prefixIconHeight: Sizes.ICON_SIZE_18,
          onChanged: (sp) => {
            context.read<BookAppointmentBloc>().add(
              PurchageNewMemberNameChanged(sp),
                )
          },
          errorText: null,
        );
      },
    );
  }
}



class _MemberDropDown extends StatefulWidget {
  @override
  __MemberDropDownState createState() => __MemberDropDownState();
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
            width: width * 0.85,
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
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
                          : const ServiceType(1, ''),
                      items: [
                        const ServiceType(1, ''),
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
                                  width: width * 0.75),
                            );
                          }).toList(),
                      // onChanged: (ServiceType serviceType) async {
                      //   // FocusScope.of(context).requestFocus(FocusNode());
                      //
                      //   context.read<BookAppointmentBloc>().add(
                      //     ServiceChanged(serviceType),
                      //   );
                      // },

                      onChanged: (serviceType){
                        context.read<BookAppointmentBloc>().add(
                                ServiceChanged(serviceType),
                              );
                      },
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


class _relationDropDown extends StatefulWidget {
  @override
  __relationDropDownState createState() => __relationDropDownState();
}



class __relationDropDownState extends State<_relationDropDown> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = assignWidth(context: context, fraction: 1.0);
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
        buildWhen: (previous, current) => previous.relation != current.relation,
        builder: (context, state) {
          // print('state' + state.service.id.toString());
          return Container(
            width: width * 0.85,
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
                      value: state.relation != null
                          ? state.relation
                          : const ServiceType(1, ''),
                      items: [
                        const ServiceType(1, ''),
                        const ServiceType(3, 'Father'),
                        const ServiceType(2, 'Mother'),
                        const ServiceType(4, 'Father-In-Law'),
                        const ServiceType(5, 'Mother-In-Law'),
                        const ServiceType(6, 'Son'),
                        const ServiceType(7, 'Daughter'),
                        const ServiceType(8, 'Husband'),
                        const ServiceType(9, 'Wife'),
                        const ServiceType(8, 'Brother'),
                        const ServiceType(9, 'Sister'),
                        const ServiceType(10, 'Grandfather'),
                        const ServiceType(11, 'Grandmother'),
                        const ServiceType(12, 'Grandson'),
                        const ServiceType(13, 'Granddaughter'),
                        const ServiceType(14, 'Uncle'),
                        const ServiceType(15, 'Aunt'),
                        const ServiceType(16, 'Nephew'),
                        const ServiceType(17, 'Niece'),
                        const ServiceType(18, 'Cousin'),
                        const ServiceType(19, 'Self'),
                        const ServiceType(20, 'Other')




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
                                  width: width * 0.75),
                            );
                          }).toList(),
                      // onChanged: (ServiceType serviceType) async {
                      //   // FocusScope.of(context).requestFocus(FocusNode());
                      //
                      //   context.read<BookAppointmentBloc>().add(
                      //     ServiceChanged(serviceType),
                      //   );
                      // },

                      onChanged: (serviceType){
                        context.read<BookAppointmentBloc>().add(
                          RelationChanged(serviceType),
                        );
                      },
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