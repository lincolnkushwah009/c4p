import 'package:care4parents/presentation/screens/activity_report/bloc/activity_tab_bloc.dart';
import 'package:care4parents/presentation/widgets/app_error_widget.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/new_record.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../activity_report.dart';
import 'activity_page_view.dart';
import 'activity_tab_constants.dart';

class ActivityTabWidget extends StatefulWidget {
  final ActivityReportController aRController;

  final int currentTabIndex;

  ActivityTabWidget(
      {Key key, @required this.currentTabIndex, this.aRController})
      : super(key: key);
  @override
  _ActivityTabWidgetState createState() =>
      _ActivityTabWidgetState(this.currentTabIndex, this.aRController);
}

class _ActivityTabWidgetState extends State<ActivityTabWidget>
    with SingleTickerProviderStateMixin {
  final ActivityReportController _aRController;

  ActivityTabBloc get activityTabBloc =>
      BlocProvider.of<ActivityTabBloc>(context);
  int currentTabIndex = 1;
  _ActivityTabWidgetState(this.currentTabIndex, this._aRController) {
    _aRController.refesh = refesh;
  }
  void refesh() {
    print('currentTabIndex============> after ' + currentTabIndex.toString());

    _onTabTapped(currentTabIndex);
  }

  @override
  void initState() {
    super.initState();
    activityTabBloc
        .add(ActivityTabChangedEvent(currentTabIndex: currentTabIndex));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<ActivityTabBloc, ActivityTabState>(
      builder: (context, state) {
        return ListView(
          // physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: TabBar(
                // isScrollable: true,
                onTap: (int index) {
                  _onTabTapped(index);
                },

                labelPadding: EdgeInsets.only(left: 0.2, right: 0.5),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColors.primaryColor,
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: AppColors.blackShade3,
                labelStyle: theme.textTheme.tabTitle
                    .copyWith(fontSize: 16.sp, letterSpacing: 0.2),
                unselectedLabelStyle: Theme.of(context)
                    .textTheme
                    .tabUnselectedTitle
                    .copyWith(fontSize: 16.sp),
                tabs: [
                  for (var i = 0;
                      i < ActivityTabConstants.appointmentTabs.length;
                      i++)
                    Tab(
                      text: ActivityTabConstants.appointmentTabs[i].title,
                    ),
                ],
              ),
            ),
            if (state is ActivityTabLoading)
              Container(child: new Container(height: 400, child: AppLoading())),
            if (state is ActivityTabChanged)
              (state.activities?.isEmpty ??
                      true && state.previousReports.isEmpty ??
                      true)
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(Sizes.PADDING_14),
                        child: new Container(
                            height: 400,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: Sizes.PADDING_6),
                                  child: Image.asset(
                                    ImagePath.EMPTY_LIST,
                                    height: Sizes.HEIGHT_110,
                                  ),
                                ),
                                SpaceH20(),
                                Text(
                                  state.currentTabIndex == 0
                                      ? StringConst.sentence.NO_Activity
                                      : state.currentTabIndex == 1
                                          ? StringConst.sentence.NO_Reports
                                          : StringConst
                                              .sentence.NO_PAST_Reports,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.subtitle1
                                      .copyWith(color: AppColors.noDataText),
                                ),
                                SpaceH36(),
                                // Container(
                                //   margin: const EdgeInsets.symmetric(
                                //       horizontal: Sizes.MARGIN_48),
                                //   child: CustomButton(
                                //       color: AppColors.primaryColor,
                                //       height: Sizes.HEIGHT_50,
                                //       borderRadius: Sizes.RADIUS_4,
                                //       textStyle:
                                //           theme.textTheme.subtitle1.copyWith(
                                //         color: AppColors.white,
                                //       ),
                                //       onPressed: () => onBookPress(),
                                //       title: CommonButtons.BOOK),
                                // ),
                              ],
                            )),
                      ),
                    )
                  : ActivityPageView(
                      activities: state.activities,
                      previousReports: state.previousReports,
                      initialPage: state.currentTabIndex,
                      onGoBack: refesh),

            // first tab bar view widget

            // Expanded(
            //           child: Column(
            //             children: [
            //               ActivityPageView(
            //                 activities: state.activities,
            //                 initialPage: state.currentTabIndex,
            //               ),
            //               // NewRecord(
            //               //     title: CommonButtons.NEW_APPOINTMET,
            //               //     onTap: () {}),
            //             ],
            //           ),
            //         ),
            if (state is ActivityTabLoadError)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.PADDING_14),
                  child: new Container(
                      height: 400,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: Sizes.PADDING_6),
                            child: Image.asset(
                              ImagePath.EMPTY_LIST,
                              height: Sizes.HEIGHT_110,
                            ),
                          ),
                          SpaceH20(),
                          Text(
                            state.currentTabIndex == 0
                                ? StringConst.sentence.NO_Activity
                                : state.currentTabIndex == 1
                                    ? StringConst.sentence.NO_Reports
                                    : StringConst.sentence.NO_PAST_Reports,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.subtitle1
                                .copyWith(color: AppColors.noDataText),
                          ),
                          SpaceH36(),
                          // Container(
                          //   margin: const EdgeInsets.symmetric(
                          //       horizontal: Sizes.MARGIN_48),
                          //   child: CustomButton(
                          //       color: AppColors.primaryColor,
                          //       height: Sizes.HEIGHT_50,
                          //       borderRadius: Sizes.RADIUS_4,
                          //       textStyle:
                          //           theme.textTheme.subtitle1.copyWith(
                          //         color: AppColors.white,
                          //       ),
                          //       onPressed: () => onBookPress(),
                          //       title: CommonButtons.BOOK),
                          // ),
                        ],
                      )),
                ),
              )
            // AppErrorWidget(
            //   errorType: state.errorType,
            //   onPressed: () => activityTabBloc.add(
            //     ActivityTabChangedEvent(
            //       currentTabIndex: state.currentTabIndex,
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
    try {
      activityTabBloc.setIsLoading(true);
      activityTabBloc.add(ActivityTabChangedEvent(currentTabIndex: index));
    } finally {
      activityTabBloc.setIsLoading(false);
    }
  }
}

void onBookPress() {}
