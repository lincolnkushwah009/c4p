import 'package:care4parents/data/models/appointment_model.dart';
import 'package:care4parents/domain/entities/appointment_entity.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:care4parents/values/values.dart';

import 'appointment_card_widget.dart';

class AppointmentPageView extends StatefulWidget {
  final List<AppointmentModel> appointments;
  final int initialPage;

  const AppointmentPageView(
      {Key key, @required this.appointments, @required this.initialPage})
      : super(key: key);

  @override
  _AppointmentPageViewState createState() => _AppointmentPageViewState();
}

class _AppointmentPageViewState extends State<AppointmentPageView> {
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return Container(
      // margin: EdgeInsets.symmetric(
      //     vertical: Sizes.MARGIN_8.sp, horizontal: Sizes.MARGIN_4.sp),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final AppointmentModel appointment = widget.appointments[index];
          return AppointmentCardWidget(
              // pageController: _pageController,
              appointment: appointment,
              appointmentId: appointment.id,
              familyMember: appointment.familyMember != null&&appointment.familyMember?.name != null
                  ? appointment.familyMember.name
                  : '',
              doctor: appointment.doctorinfo != null
                  ? 'Dr. ' + appointment.doctorinfo.name
                  : '',
              time: appointment.timerange != null &&
                      appointment.timerange.contains('-') &&
                      appointment.timerange.split('-').length > 0
                  ? '${appointment.timerange.split('-')[0]} - ${appointment.timerange.split('-')[1]}'
                  : '',
              appointment_date: appointment.appointDate != null
                  ? DateFormat.yMMMd()
                      .format(DateTime.parse(appointment.appointDate))
                  : '',
              speciality:
                  appointment.speciality != null ? appointment.speciality : '',
              showCancel: widget.initialPage == 0 ? true : false,
              color: widget.initialPage == 0
                  ? AppColors.primaryColor
                  : widget.initialPage == 1
                      ? AppColors.orange
                      : AppColors.grey);
        },
        // pageSnapping: true,
        itemCount: widget.appointments?.length ?? 0,
        // onPageChanged: (index) {
        //   BlocProvider.of<AppointmentBackdropBloc>(context)
        //       .add(AppointmentBackdropChangedEvent(widget.appointments[index]));
        // },
        // scrollDirection: Axis.vertical,
      ),
    );
  }
}
