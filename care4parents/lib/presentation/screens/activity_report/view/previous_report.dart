import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
class PreReportCardWidget extends StatelessWidget {
  final int index,activitieslength;
  final String reportType;
  final String reportlink;
  final String date;
  // final String status;
  final Color color;

  const PreReportCardWidget({
    Key key,
    @required this.index,this.activitieslength,
    @required this.date,
    @required this.reportType,
    @required this.reportlink,
    // @required this.status,
    @required this.color,
  }) : super(key: key);
  void _launchURL(url)  =>{
    ExtendedNavigator.root.push(Routes.PdfViewer,
        arguments: PdfViewScreenArguments(
          pdfUrl:url, )
    )

  };
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(bottom:activitieslength-1==index? 120:0),
      margin: EdgeInsets.only(top: Sizes.MARGIN_12),
      child: Material(
        elevation: Sizes.ELEVATION_10,
        borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(
            //   RouteList.appointmentDetail,
            //   arguments: AppointmentDetailArguments(activityId),
            // );
          },
          child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.RADIUS_16),
              child: Padding(
                padding: EdgeInsets.all(Sizes.PADDING_8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Expanded(child:  Text(
                         reportType != null ? reportType : '',
                         style: theme.textTheme.headline6.copyWith(
                             color: AppColors.black, fontWeight: FontWeight.w800),
                       ),
                       ),

                        reportlink!=null&& reportlink!=""? new GestureDetector(child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              StringConst.VIEW_REPORT,
                              style: theme.textTheme.caption.copyWith(
                                  fontWeight: FontWeight.w900, color: color),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 12,
                              color: color,
                            )
                          ],
                        ),onTap: (){
                          print("reportlink "+reportlink);
                          print("reportlink previos >> https://apis.care4parents.in/images/uploads/"+reportlink);
                          _launchURL("https://apis.care4parents.in"+reportlink);
                        },):new Container(),
                      ],
                    ),





                    SpaceH4(),
                    Text(
                      date != null ? 'Date of Testing: ' +DateFormat.yMMMd()
                          .format(DateTime.parse(date))  : '',
                      style: theme.textTheme.bodyText2
                          .copyWith(fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
