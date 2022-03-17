import 'package:care4parents/data/models/activity_result.dart';
import 'package:care4parents/data/models/previous_report_result.dart';

import 'package:care4parents/presentation/screens/activity_report/view/previous_report.dart';
import 'package:flutter/material.dart';

import 'package:care4parents/values/values.dart';

import 'activity_card_widget.dart';

class ActivityPageView extends StatefulWidget {
  final List<ActivityResult> activities;
  final List<PreviousReport> previousReports;
  final Function onGoBack;
  final int initialPage;

  const ActivityPageView(
      {Key key,
      this.activities,
      @required this.initialPage,
      @required this.onGoBack,
      this.previousReports})
      : super(key: key);

  @override
  _ActivityPageViewState createState() => _ActivityPageViewState();
}

class _ActivityPageViewState extends State<ActivityPageView> {
  // PageController _pageController;
//  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      margin: EdgeInsets.only(bottom: Sizes.MARGIN_32,top: Sizes.MARGIN_10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (widget.activities != null &&
              (widget.initialPage == 0 || widget.initialPage == 1)) {
            final ActivityResult activity = widget.activities[index];
            return ActivityCardWidget(
              onGoBack: widget.onGoBack,
              index: index,
              activitieslength:widget.activities.length,
              status: activity.status,
              activityId: activity.id,
              showForwardIcon: widget.initialPage == 1 ? true : false,
              execution_date: activity.executionDate,
              schedule_date: activity.scheduleDate,
              name: activity.services.name,
              vitalVals: activity.vitalVals,
              color: widget.initialPage == 0
                  ? AppColors.primaryColor
                  : widget.initialPage == 1
                      ? AppColors.orange
                      : AppColors.primaryColor,
              reportlink:
                  activity.reportfile != null && activity.reportfile.url != null
                      ? activity.reportfile.url
                      : "",
            );
          } else if (widget.initialPage == 2) {
            final PreviousReport previousReport = widget.previousReports[index];
            return PreReportCardWidget(
                index: index,
                activitieslength:widget.previousReports.length,
                reportType: previousReport.reportType,
                date: previousReport.dateOfTest,
                reportlink: previousReport.reportfile != null &&
                        previousReport.reportfile.url != null
                    ? previousReport.reportfile.url
                    : "",
                color: widget.initialPage == 0
                    ? AppColors.primaryColor
                    : widget.initialPage == 1
                        ? AppColors.orange
                        : AppColors.primaryColor);
          }

          // if (widget.initialPage == 2)
          //   return PreReportCardWidget(
          //       index: index,
          //       // pageController: _pageController,
          //       status: activity.status,
          //       reportType: previousReport.reportType,
          //       date: previousReport.dateOfTest,
          //       reportlink: previousReport.reportfile.url,
          //       color: widget.initialPage == 0
          //           ? AppColors.primaryColor
          //           : widget.initialPage == 1
          //               ? AppColors.orange
          //               : AppColors.grey);
        },
        // pageSnapping: true,
        itemCount: widget.activities != null
            ? widget.activities?.length ?? 0
            : widget.previousReports?.length ?? 0,
        // onPageChanged: (index) {
        //   BlocProvider.of<ActivityBackdropBloc>(context)
        //       .add(ActivityBackdropChangedEvent(widget.activity[index]));
        // },
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
