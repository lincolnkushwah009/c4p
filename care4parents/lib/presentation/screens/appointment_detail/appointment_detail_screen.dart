import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/appointment_model.dart';
import 'package:care4parents/data/models/prescription.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/widgets/auth/bg_card_auto.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/divider_widget.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/appointment_detail_bloc.dart';

const kSpacingUnit = 10;

class AppointmentDetailScreen extends StatefulWidget {
  final AppointmentModel appointment;
  const AppointmentDetailScreen({Key key, @required this.appointment})
      : super(key: key);

  @override
  _AppointmentDetailScreenState createState() =>
      _AppointmentDetailScreenState(this.appointment);
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  AppointmentModel _appointment;
  AppointmentDetailBloc _appointmentDetailBloc;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  _AppointmentDetailScreenState(AppointmentModel user) {
    this._appointment = user;
  }
  @override
  void initState() {
    _appointmentDetailBloc = getItInstance<AppointmentDetailBloc>();
    _appointmentDetailBloc.add(GetPrescription(id: _appointment.id));
    super.initState();
  }
  void _launchURL(url)  =>{
  ExtendedNavigator.root.push(Routes.PdfViewer,
      arguments: PdfViewScreenArguments(
          pdfUrl:url, )
  )

  };

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (context) => _appointmentDetailBloc,
      child: Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
          child: CustomAppBar(
              title: StringConst.View_APPOINTMMENT,
              // onLeadingTap: () => _openDrawer(),
              leading: InkWell(
                  onTap: () => ExtendedNavigator.root.pop(),
                  child: Icon(Icons.arrow_back_ios_outlined)),
              trailing: [

                new whatappIconwidget(isHeader:true)
              ],
              hasTrailing: true),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Doctor details',
                        style: theme.textTheme.caption
                            .copyWith(color: AppColors.noDataText)),
                  ),
                  Center(
                    child: BgCardAuto(
                      padding: EdgeInsets.all(0.0),
                      width: widthOfScreen * 0.9,

                      borderRadius: const BorderRadius.all(
                        const Radius.circular(Sizes.RADIUS_4),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(Sizes.RADIUS_4),
                            ),
                            child: Container(
                              color: AppColors.primaryColor.withOpacity(0.4),
                              width: widthOfScreen * 0.3,
                              height: heightOfScreen * 0.2,
                              child: Center(
                                child: Text(
                                  _appointment.doctorinfo.firstname.characters
                                          .first +
                                      _appointment
                                          .doctorinfo.lastname.characters.first,
                                  style: theme.textTheme.headline6.copyWith(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.9),
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (_appointment.speciality != null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Text(
                                      _appointment.speciality,
                                      style: theme.textTheme.caption.copyWith(
                                          fontWeight: FontWeight.w200,
                                          color: AppColors.primaryText),
                                    ),
                                  ),
                               new Column(children: [

                                SizedBox(

                                  width: widthOfScreen * 0.5,
                                  child:  Text(
                                  _appointment.doctorinfo != null
                                      ? 'Dr. ' + _appointment.doctorinfo.name
                                      : '',
                                  style: theme.textTheme.headline6.copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w800),
                                ),),],),
                                Row(
                                  children: [
                                    Icon(Icons.school,
                                        color: AppColors.grey, size: 12),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: SizedBox(
                                        width: 50,
                                        child: Text(
                                        _appointment.doctorinfo.degree,
                                        style: theme.textTheme.bodyText2
                                            .copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),),
                                    ),
                                  ],
                                ),
                                if (_appointment.doctorinfo.email != null)
                                  Row(
                                    children: [
                                      Icon(Icons.email,
                                          color: AppColors.grey, size: 12),


                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: new Column(children: [SizedBox(
                                          width:  widthOfScreen * 0.5,child:Text(
                                          _appointment.doctorinfo.email,
                                          style: theme.textTheme.caption
                                              .copyWith(
                                              color: AppColors.primaryText,
                                              fontWeight: FontWeight.w200),
                                        ))],),
                                      ),
                                    ],
                                  ),
                                if (_appointment.doctorinfo.phone != null)
                                  Row(
                                    children: [
                                      Icon(Icons.phone,
                                          color: AppColors.grey, size: 12),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          _appointment.doctorinfo.phone,
                                          style: theme.textTheme.bodyText2
                                              .copyWith(
                                                  fontWeight: FontWeight.w200),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SpaceH12(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Appointment details',
                        style: theme.textTheme.caption
                            .copyWith(color: AppColors.noDataText)),
                  ),
                  Center(
                    child: BgCardAuto(
                      // backgroundColor: AppColors.backLight.withOpacity(0.1),
                      padding: EdgeInsets.all(0.0),
                      width: widthOfScreen * 0.9,
                      height: heightOfScreen * 0.18,
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(Sizes.RADIUS_4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SpaceH4(),

                            Row(
                              children: [
                                SpaceW12(),
                                Icon(Icons.event,
                                    color: AppColors.primaryColor, size: 15),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    DateFormat.yMMMd().format(
                                        DateTime.parse(
                                            _appointment.appointDate)),
                                    style: theme.textTheme.subtitle2
                                        .copyWith(
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    DateFormat.jm().format(DateTime.parse(
                                        _appointment
                                            .startappointdate)) +
                                        ' - ' +
                                        DateFormat.jm().format(
                                            DateTime.parse(_appointment
                                                .endappointdate)),
                                    style: theme.textTheme.subtitle2
                                        .copyWith(
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ],
                            ),



                            SpaceH4(),


                            Row(
                              children: [
                                SpaceW12(),
                                Icon(Icons.category,
                                    color: AppColors.primaryColor, size: 15),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    _appointment.speciality,
                                    style: theme.textTheme.subtitle2
                                        .copyWith(
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ],
                            ),
                            SpaceH4(),



                            Row(
                              children: [
                                SpaceW12(),
                                Icon(Icons.email,
                                    color: AppColors.primaryColor, size: 15),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    _appointment.email,
                                    style: theme.textTheme.subtitle2
                                        .copyWith(
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ],
                            ),

                            SpaceH4(),

                            Row(
                              children: [
                                SpaceW12(),
                                Icon(Icons.phone,
                                    color: AppColors.primaryColor, size: 15),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    _appointment.phone,
                                    style: theme.textTheme.subtitle2
                                        .copyWith(
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ],
                            ),

                            SpaceH4(),
                            if (_appointment.remarks != null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SpaceW4(),
                                    Icon(
                                      Icons.info,
                                        color: AppColors.primaryColor, size: 15),
                                    SpaceW4(),
                                    Text(
                                      _appointment.remarks,
                                      style: theme.textTheme.subtitle2.copyWith(

                                          fontWeight: FontWeight.w200),
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SpaceH12(),
                  BlocBuilder<AppointmentDetailBloc, AppointmentDetailState>(
                    builder: (context, state) {
                      if (state is Loaded && !state.prescriptions.isEmpty)
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Prescription / Medicines Info',
                                    style: theme.textTheme.caption
                                        .copyWith(color: AppColors.noDataText)),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.prescriptions != null
                                  ? state.prescriptions?.length
                                  : 0,
                              itemBuilder: (context, index) {
                                final Prescription prescription =
                                    state.prescriptions[index];
                                return Center(
                                  child: BgCardAuto(
                                      // backgroundColor: AppColors.backLight.withOpacity(0.1),
                                      padding: EdgeInsets.all(16.0),
                                      width: widthOfScreen * 0.9,
                                      height: heightOfScreen * 0.4,
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(Sizes.RADIUS_4),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Icon(
                                              //   Icons.bloodT,
                                              //   color: AppColors.lightButton,
                                              //   size: 32,
                                              // ),

                                        Expanded(child:      new Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          Text(
                                        prescription
                                            .medicineinfo?.name!=null? prescription
                                                .medicineinfo.name.toString():"",
                                            style: theme
                                                .textTheme.headline6
                                                .copyWith(
                                                fontWeight:
                                                FontWeight.w200),
                                          )
                                        ],),),
                                            prescription.prescriptionFile!=null&&    prescription.prescriptionFile!=""? GestureDetector(child: Row(
                                                children: [
                                                  Text(
                                                    StringConst.Prescription,

                                                    style: theme.textTheme.caption.copyWith(
                                                      fontWeight: FontWeight.w900,
                                                      color: AppColors.primaryColor,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios_outlined,
                                                    size: 12,
                                                    color: AppColors.primaryColor,
                                                  )
                                                ],
                                              ),
                                                  onTap: (){
                                                    _launchURL(prescription.prescriptionFile);
                                                  }):new Container()
                                            ],
                                          ),
                                          DividerGrey(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'ROUTE',
                                                    style: theme
                                                        .textTheme.caption
                                                        .copyWith(
                                                            color:
                                                                AppColors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                  ),
                                                  SpaceH4(),
                                                  Text(
                                                    prescription.route,
                                                    style: theme
                                                        .textTheme.bodyText1
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'INTAKE',
                                                    style: theme
                                                        .textTheme.caption
                                                        .copyWith(
                                                            color:
                                                                AppColors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                  ),
                                                  SpaceH4(),
                                                  Text(
                                                    prescription.intake,
                                                    style: theme
                                                        .textTheme.bodyText1
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'START DATE',
                                                    style: theme
                                                        .textTheme.caption
                                                        .copyWith(
                                                            color:
                                                                AppColors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                  ),
                                                  SpaceH4(),
                                                  Text(
                                                    DateFormat.yMMMd().format(
                                                        DateTime.parse(
                                                            prescription
                                                                .startDate)),
                                                    style: theme
                                                        .textTheme.bodyText1
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'END DATE',
                                                    style: theme
                                                        .textTheme.caption
                                                        .copyWith(
                                                            color:
                                                                AppColors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                  ),
                                                  SpaceH4(),
                                                  Text(
                                                    DateFormat.yMMMd().format(
                                                        DateTime.parse(
                                                            prescription
                                                                .endDate)),
                                                    style: theme
                                                        .textTheme.bodyText1
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          // DividerGrey(),
                                          SpaceH4(),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text('Frequency: ',
                                                style: theme.textTheme.caption
                                                    .copyWith(
                                                        color: AppColors.grey)),
                                          ),
                                          SpaceH4(),
                                          Row(
                                            children: [
                                              if (prescription.premorning)
                                                FrequecyText(
                                                    color:
                                                        AppColors.primaryColor,
                                                    text: 'Pre-Morning',


                                                    status:prescription.premorning),
                                              SpaceW8(),
                                              if (prescription.morning)
                                                FrequecyText(
                                                    color: AppColors.red,
                                                    text: 'Morning',
                                                    status:prescription.morning),
                                            ],
                                          ),
                                          SpaceH4(),
                                          Row(
                                            children: [
                                              if (prescription.afternoon)
                                                FrequecyText(
                                                    color: AppColors.lightBlue,
                                                    text: 'Afternoon',
                                                    status:prescription.afternoon),
                                              SpaceW8(),
                                              if (prescription.evening)
                                                FrequecyText(
                                                    color: AppColors.pink,
                                                    text: 'Evening',
                                                    status:prescription.evening),
                                              SpaceW8(),
                                              if (prescription.bedtime)
                                                FrequecyText(
                                                    color: AppColors.blue,
                                                    text: 'Bedtime',
                                                    status:prescription.bedtime)
                                            ],
                                          ),
                                          DividerGrey(),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SpaceW4(),
                                                Icon(
                                                  Icons.info,
                                                  color: AppColors.grey,
                                                  size: 16,
                                                ),
                                                SpaceW4(),
                                                Flexible(
                                                child: Text(
                                                    prescription.remarks,
                                                    style: theme.textTheme.subtitle2
                                                        .copyWith(

                                                            fontWeight:
                                                                FontWeight.w200),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                );
                              },
                            ),
                          ],
                        );
                      return Container();
                    },
                  ),
                  SpaceH12(),
                   BlocBuilder<AppointmentDetailBloc, AppointmentDetailState>(
                    builder: (context, state) {
                      if (state is Loaded && state.immunization != null && !state.immunization.isEmpty)
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Immunizations Info',
                                    style: theme.textTheme.caption
                                        .copyWith(color: AppColors.noDataText)),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.immunization != null
                                  ? state.immunization?.length
                                  : 0,
                              itemBuilder: (context, index) {
                                final Immunization immunization =
                                    state.immunization[index];
                                return Center(
                                  child: BgCardAuto(
                                      // backgroundColor: AppColors.backLight.withOpacity(0.1),
                                      padding: EdgeInsets.all(16.0),
                                      width: widthOfScreen * 0.9,
                                      height: heightOfScreen * 0.4,
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(Sizes.RADIUS_4),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Icon(
                                              //   Icons.bloodT,
                                              //   color: AppColors.lightButton,
                                              //   size: 32,
                                              // ),
                                              Expanded(child:new Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    immunization.name+"",
                                                    style: theme
                                                        .textTheme.headline6
                                                        .copyWith(
                                                        fontWeight:
                                                        FontWeight.w200),
                                                  )
                                                ],),),


                                              immunization.prescriptionFile!=null&&    immunization.prescriptionFile!=""? GestureDetector(child: Row(
                                                children: [
                                                  Text(
                                                    StringConst.Prescription,
                                                    style: theme.textTheme.caption.copyWith(
                                                      fontWeight: FontWeight.w900,
                                                      color: AppColors.primaryColor,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios_outlined,
                                                    size: 12,
                                                    color: AppColors.primaryColor,
                                                  )
                                                ],
                                              ),
                                                onTap: (){
                                                  _launchURL(immunization.prescriptionFile);
                                                }):new Container()
                                            ],
                                          ),
                                          DividerGrey(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'ROUTE',
                                                    style: theme
                                                        .textTheme.caption
                                                        .copyWith(
                                                            color:
                                                                AppColors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                  ),
                                                  SpaceH4(),
                                                  Text(
                                                    immunization.route,
                                                    style: theme
                                                        .textTheme.bodyText1
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                  ),
                                                ],
                                              ),
                                              // Column(
                                              //   children: [
                                              //     Text(
                                              //       'INTAKE',
                                              //       style: theme
                                              //           .textTheme.caption
                                              //           .copyWith(
                                              //               color:
                                              //                   AppColors.grey,
                                              //               fontWeight:
                                              //                   FontWeight
                                              //                       .w200),
                                              //     ),
                                              //     SpaceH4(),
                                              //     Text(
                                              //       prescription.intake,
                                              //       style: theme
                                              //           .textTheme.bodyText1
                                              //           .copyWith(
                                              //               fontWeight:
                                              //                   FontWeight
                                              //                       .w200),
                                              //     ),
                                              //   ],
                                              // ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Date of Immunization',
                                                    style: theme
                                                        .textTheme.caption
                                                        .copyWith(
                                                            color:
                                                                AppColors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                  ),
                                                  SpaceH4(),
                                                  Text(
                                                    DateFormat.yMMMd().format(
                                                        DateTime.parse(
                                                            immunization
                                                                .startDate)),
                                                    style: theme
                                                        .textTheme.bodyText1
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                  ),
                                                ],
                                              ),
                                              // Column(
                                              //   children: [
                                              //     Text(
                                              //       'END DATE',
                                              //       style: theme
                                              //           .textTheme.caption
                                              //           .copyWith(
                                              //               color:
                                              //                   AppColors.grey,
                                              //               fontWeight:
                                              //                   FontWeight
                                              //                       .w200),
                                              //     ),
                                              //     SpaceH4(),
                                              //     Text(
                                              //       DateFormat.yMMMd().format(
                                              //           DateTime.parse(
                                              //               prescription
                                              //                   .endDate)),
                                              //       style: theme
                                              //           .textTheme.bodyText1
                                              //           .copyWith(
                                              //               fontWeight:
                                              //                   FontWeight
                                              //                       .w200),
                                              //     ),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                          // DividerGrey(),
                                          SpaceH4(),
                                         
                                          DividerGrey(),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SpaceW4(),
                                                Icon(
                                                  Icons.info,
                                                  color: AppColors.grey,
                                                  size: 16,
                                                ),
                                                SpaceW4(),
                                                Flexible(
                                                                                                  child: Text(
                                                    immunization.remarks,
                                                    style: theme.textTheme.subtitle2
                                                        .copyWith(

                                                            fontWeight:
                                                                FontWeight.w200),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                );
                              },
                            ),
                          ],
                        );
                      return Container();
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class FrequecyText extends StatelessWidget {
  const FrequecyText({
    Key key,
    @required this.color,
    @required this.text,this.status
  }) : super(key: key);

  final Color color;
  final String text;
  final bool status;
  @override
  Widget build(BuildContext context) {
    const double TEXT_BACK_OPACITY = 0.2;

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(TEXT_BACK_OPACITY),
        borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
      ),
      child: new Row(children: [
        Padding(
          padding: const EdgeInsets.all(Sizes.PADDING_2),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Sizes.PADDING_2),
          child:   Icon(
            status?Icons.check_circle:Icons.cancel,
            color: AppColors.grey,
            size: 16,
          ),
        ),
      ],),
    );
  }
}
