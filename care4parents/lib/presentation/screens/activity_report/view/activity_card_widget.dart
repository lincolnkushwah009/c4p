import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/report_detail.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ActivityCardWidget extends StatelessWidget {
  final int index,activitieslength;
  final int activityId;
  final String name;
  final String schedule_date;
  final String execution_date;
  final String status, reportlink;
  final bool showForwardIcon;
  final Color color;
  final List<VitalVal> vitalVals;
  final Function onGoBack;

  const ActivityCardWidget(
      {Key key,
      @required this.index,
      @required this.activityId,
        this.activitieslength,
      @required this.name,
      @required this.schedule_date,
      @required this.execution_date,
      @required this.status,
      @required this.showForwardIcon,
      @required this.onGoBack,
      this.vitalVals,
      @required this.color,
      this.reportlink})
      : super(key: key);
  void _launchURL(url)  =>{
    ExtendedNavigator.root.push(Routes.PdfViewer,
        arguments: PdfViewScreenArguments(
          pdfUrl:url, )
    )

  };
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding: EdgeInsets.only(bottom:activitieslength-1==index? 120:0),
        margin: EdgeInsets.only(top: Sizes.MARGIN_12),
        child: Material(
          elevation: Sizes.ELEVATION_10,
          borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
          // child: InkWell(
          //   onTap: () {
          //     print('cevfgrgerfergergergergeg erferferre ffeferregegerbrgre ');
          //     // Navigator.of(context).pushNamed(
          //     //   RouteList.appointmentDetail,
          //     //   arguments: AppointmentDetailArguments(activityId),
          //     // );
          //     ExtendedNavigator.root.push(Routes.reportDetailScreen,
          //         arguments: ReportDetailScreenArguments(vitalVals: vitalVals));
          //   },
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
                        Text(
                          status != null ? status : '',
                          style: theme.textTheme.subtitle1.copyWith(
                            color: color,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        reportlink != null &&
                                reportlink != "" &&
                                reportlink != 'No-link' &&
                                reportlink != 'no-link'
                            ? new GestureDetector(
                                child: Row(
                                  children: [
                                    Text(
                                      StringConst.VIEW_REPORT,
                                      style: theme.textTheme.caption.copyWith(
                                          fontWeight: FontWeight.w900,
                                          color: color),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 12,
                                      color: color,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  print("reportlink " + reportlink);
                                  print(
                                      "reportlink activity>> https://apis.care4parents.in" +
                                          reportlink);
                                  _launchURL("https://apis.care4parents.in" +
                                      reportlink);

                                  // ExtendedNavigator.root.push(
                                  //     Routes.reportDetailScreen,
                                  //     arguments: ReportDetailScreenArguments(
                                  //         vitalVals: vitalVals));
                                  // print('vitalVals' + vitalVals.toString());
                                },
                              )
                            : new Container(),
                      ],
                    ),
                    SpaceH4(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name != null ? name  : '',
                          style: theme.textTheme.headline6.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    SpaceH4(),
                    Text(
                      schedule_date != null
                          ? 'Schedule Date: ' +
                              DateFormat.yMMMd()
                                  .format(DateTime.parse(schedule_date))
                          : '',
                      style: theme.textTheme.bodyText2
                          .copyWith(fontWeight: FontWeight.w200),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          execution_date != null
                              ? 'Execution Date: ' +
                                  DateFormat.yMMMd()
                                      .format(DateTime.parse(execution_date))
                              : '',
                          style: theme.textTheme.bodyText2
                              .copyWith(fontWeight: FontWeight.w200),
                        ),
                        showForwardIcon
                            ? InkWell(
                                onTap: () => {
                                  ExtendedNavigator.root
                                      .push(Routes.reportDetailScreen,
                                          arguments:
                                              ReportDetailScreenArguments(
                                                  vitalVals: vitalVals,
                                                  isSearch: false))
                                      .then(onGoBack1),
                                  print('vitalVals' + vitalVals.toString())
                                },
                                child: Icon(Icons.arrow_forward_ios,
                                    color: AppColors.black),
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
              )),
          // ),
        ),
      ),
    );
  }

  Future<bool> onGoBack1(dynamic value) async {
    print('onGoBack1 call');
    this.onGoBack();
    return true;
  }
}
