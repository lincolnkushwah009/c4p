import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';

class ServiceCardWidget extends StatelessWidget {
  final int index;
  final int appointmentId;
  final String speciality;
  final String appointment_date;
  // final String specialist_type;
  final String provider;
  final String time;
  final Color color;

  const ServiceCardWidget({
    Key key,
    @required this.index,
    @required this.appointmentId,
    @required this.speciality,
    // @required this.specialist_type,
    @required this.appointment_date,
    @required this.provider,
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
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(
            //   RouteList.appointmentDetail,
            //   arguments: AppointmentDetailArguments(appointmentId),
            // );
          },
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
                      provider,
                      style: theme.textTheme.headline6.copyWith(
                          color: AppColors.black, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      speciality,
                      style: theme.textTheme.bodyText2.copyWith(
                          color: AppColors.black, fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
