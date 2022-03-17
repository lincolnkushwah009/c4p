import 'package:care4parents/domain/entities/appointment_entity.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:care4parents/values/values.dart';

import 'service_card_widget.dart';

class ServicePageView extends StatefulWidget {
  final List<Service> appointments;
  final int initialPage;

  const ServicePageView(
      {Key key, @required this.appointments, @required this.initialPage})
      : super(key: key);

  @override
  _ServicePageViewState createState() => _ServicePageViewState();
}

class _ServicePageViewState extends State<ServicePageView> {
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
          final Service appointment = widget.appointments[index];
          return ServiceCardWidget(
              index: index,
              // pageController: _pageController,
              appointmentId: appointment.id,
              provider: appointment.providerinfo != null
                  ? appointment.providerinfo.name
                  : '---',
              speciality: appointment.service,
              time: (appointment.timerange != null &&
                      appointment.timerange.split(' ').length > 0)
                  ? '${appointment.timerange.split('-')[0]}-${appointment.timerange.split('-')[1]}'
                  : '',
              appointment_date: DateFormat.yMMMd()
                  .format(DateTime.parse(appointment.bookingdate)),
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
