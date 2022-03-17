import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/appontment/bloc/appointment_tab_bloc.dart';
import 'package:care4parents/presentation/screens/appontment/view/appointment_page_view.dart';
import 'package:care4parents/presentation/screens/appontment/view/appointment_tab_constants.dart';
import 'package:care4parents/presentation/widgets/app_error_widget.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/custom_button.dart';
import 'package:care4parents/presentation/widgets/new_record.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'appointment_screen.dart';
import 'appointment_tab_constants.dart';

class AppointmentTabWidget extends StatefulWidget {
  final HomePageController controller;

  AppointmentTabWidget({this.controller});
  @override
  _AppointmentTabWidgetState createState() =>
      _AppointmentTabWidgetState(controller);
}

class _AppointmentTabWidgetState extends State<AppointmentTabWidget>
    with SingleTickerProviderStateMixin {
  AppointmentTabBloc get appointmentTabBloc =>
      BlocProvider.of<AppointmentTabBloc>(context);
  int currentTabIndex = 0;

  _AppointmentTabWidgetState(HomePageController _controller) {
    _controller.goBack = goBack;
  }

  void goBack() {
    _onTabTapped(currentTabIndex);
  }

  @override
  void initState() {
    super.initState();
    appointmentTabBloc
        .add(AppointmentTabChangedEvent(currentTabIndex: currentTabIndex));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<AppointmentTabBloc, AppointmentTabState>(
      builder: (context, state) {
        return ListView(
          //fixme
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: TabBar(
                // isScrollable: true,
                onTap: (int index) {
                  _onTabTapped(index);
                },
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColors.primaryColor,
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: AppColors.blackShade3,
                labelStyle: theme.textTheme.tabTitle,
                unselectedLabelStyle:
                    Theme.of(context).textTheme.tabUnselectedTitle,
                tabs: [
                  for (var i = 0;
                      i < AppointmentTabConstants.appointmentTabs.length;
                      i++)
                    Tab(
                      text: AppointmentTabConstants.appointmentTabs[i].title,
                    ),
                ],
              ),
            ),
            if (state is AppointmentTabLoading)
              Container(child: new Container(height: 400, child: AppLoading())),
            if (state is AppointmentTabChanged)
              state.appointments?.isEmpty ?? true
                  ? Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(Sizes.PADDING_14),
                          child: new Container(
                            height: 400,
                            child: Column(
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
                                Center(
                                  child: Text(
                                    state.currentTabIndex == 0
                                        ? StringConst.sentence.NO_UP_APPOINTMETS
                                        : state.currentTabIndex == 1
                                            ? StringConst
                                                .sentence.NO_REQ_APPOINTMETS
                                            : StringConst
                                                .sentence.NO_PAST_APPOINTMETS,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.subtitle1
                                        .copyWith(color: AppColors.noDataText),
                                  ),
                                ),
                                SpaceH20(),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: Sizes.MARGIN_60),
                                  child: CustomButton(
                                      color: AppColors.primaryColor,
                                      height: Sizes.HEIGHT_50,
                                      borderRadius: Sizes.RADIUS_4,
                                      textStyle:
                                          theme.textTheme.subtitle1.copyWith(
                                        color: AppColors.white,
                                      ),
                                      onPressed: () => onBookPress(),
                                      title: CommonButtons.BOOK),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
//                          NewRecord(
//                              title: CommonButtons.NEW_APPOINTMET,
//                              onTap: () {
//                                ExtendedNavigator.root
//                                    .push(Routes.bookAppointmentScreen)
//                                    .then(onGoBack);
//                              }),
                          AppointmentPageView(
                            appointments: state.appointments,
                            initialPage: state.currentTabIndex,
                          ),
                        ],
                      ),
                    ),
            // TabBarView(
            //   children: AppointmentTabConstants.appointmentTabs
            //       .map<Widget>((e) => BlocProvider(
            //             create: (_) => appointmentTabBloc,
            //             child: AppointmentPageView(
            //               appointments: state.appointments,
            //               initialPage: state.currentTabIndex,
            //             ),
            //           ))
            //       .toList(),
            // ),

            if (state is AppointmentTabLoadError)
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(Sizes.PADDING_14),
                    child: new Container(
                      height: 400,
                      child: Column(
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
                          Center(
                            child: Text(
                              state.currentTabIndex == 0
                                  ? StringConst.sentence.NO_UP_APPOINTMETS
                                  : state.currentTabIndex == 1
                                      ? StringConst.sentence.NO_REQ_APPOINTMETS
                                      : StringConst
                                          .sentence.NO_PAST_APPOINTMETS,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.subtitle1
                                  .copyWith(color: AppColors.noDataText),
                            ),
                          ),
                          SpaceH20(),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: Sizes.MARGIN_60),
                            child: CustomButton(
                                color: AppColors.primaryColor,
                                height: Sizes.HEIGHT_50,
                                borderRadius: Sizes.RADIUS_4,
                                textStyle: theme.textTheme.subtitle1.copyWith(
                                  color: AppColors.white,
                                ),
                                onPressed: () => onBookPress(),
                                title: CommonButtons.BOOK),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // Expanded(
            //   child: TabBarView(children: [
            //     // first tab bar view widget
            //   ]),
            // ),
          ],
        );
      },
    );
  }

  void _onTabTapped(int index) {
    try {
      setState(() {
        currentTabIndex = index;
      });
      appointmentTabBloc.setIsLoading(true);
      appointmentTabBloc
          .add(AppointmentTabChangedEvent(currentTabIndex: index));
    } finally {
      appointmentTabBloc.setIsLoading(false);
    }
  }

  void onBookPress() {
    ExtendedNavigator.root.push(Routes.bookAppointmentScreen).then(onGoBack);
    // ExtendedNavigator.root
    //     .push(Routes.appointmentPayment,
    //         arguments: AppointmentPaymentArguments(appointment_id: 1))
    //     .then(onGoBack);
  }

  Future<bool> onGoBack(dynamic value) async {
    _onTabTapped(currentTabIndex);
    return true;
  }
}
