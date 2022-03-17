import 'package:care4parents/data/models/appointment_model.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/appontment/bloc/appointment_tab_bloc.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentCardWidget extends StatelessWidget {
  final AppointmentModel appointment;
  final int appointmentId;
  final String doctor;
  final String familyMember;
  final String appointment_date;
  final String speciality;
  final bool showCancel;
  final String time;
  final Color color;

  const AppointmentCardWidget({
    Key key,
    @required this.appointment,
    @required this.appointmentId,
    @required this.doctor,
    @required this.familyMember,
    @required this.speciality,
    @required this.appointment_date,
    @required this.showCancel,
    @required this.time,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);

    return Container(
      // height: heightOfScreen * 0.25,
      margin: EdgeInsets.only(top: Sizes.MARGIN_12),
      child: Material(
        elevation: Sizes.ELEVATION_10,
        borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.RADIUS_16),
            child: Padding(
              padding: EdgeInsets.all((Sizes.PADDING_20).w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: appointment_date,
                      style: theme.textTheme.subtitle1.copyWith(
                        color: color,
                        fontWeight: FontWeight.w200,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ' + time,
                          style: theme.textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SpaceH8(),
                  Text(
                      familyMember!=null&&  familyMember!=""? familyMember.capitalize().toString():"",
                    style: theme.textTheme.headline6.copyWith(
                        color: AppColors.black, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor,
                            style: theme.textTheme.bodyText2
                                .copyWith(fontWeight: FontWeight.w200),
                          ),
                          Text(
                            speciality,
                            style: theme.textTheme.bodyText2
                                .copyWith(fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (doctor != '' && doctor != null)
                              OutlineButton(
                                child: new Text("View"),
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    Routes.appointmentDetailScreen,
                                    arguments: AppointmentDetailScreenArguments(
                                        appointment: appointment),
                                  );
                                },
                              ),
                            if (showCancel)
                              BlocBuilder<AppointmentTabBloc,
                                  AppointmentTabState>(
                                builder: (context, state) {
                                  return ButtonTheme(
                                    minWidth: 35.0,
                                    height: 30.0,
                                    child: RaisedButton(
                                      child: new Text("Cancel"),
                                      color: AppColors.red,
                                      textColor: AppColors.white,
                                      onPressed: () {
                                        context
                                            .read<AppointmentTabBloc>()
                                            .setIsLoading(true);
                                        context.read<AppointmentTabBloc>().add(
                                            (CancelAppointment(
                                                appointment_id:
                                                    appointment.id)));
                                      },
                                    ),
                                  );
                                },
                              )
                          ])
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
