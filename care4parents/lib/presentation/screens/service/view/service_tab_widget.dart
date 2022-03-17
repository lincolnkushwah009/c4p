import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/appontment/bloc/appointment_tab_bloc.dart';
import 'package:care4parents/presentation/screens/appontment/view/appointment_page_view.dart';
import 'package:care4parents/presentation/ui_model/tab.dart';
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

import '../service.dart';
import 'service_page_view.dart';

class ServiceTabConstants {
  static const List<NewTab> serviceTabs = const [
    const NewTab(index: 1, title: StringConst.REQUESTED_TAB),
    const NewTab(index: 0, title: StringConst.UPCOMING_TAB),
    const NewTab(index: 2, title: StringConst.PAST_TAB),
  ];
}

class ServiceTabWidget extends StatefulWidget {
  final ServicePageController controller;
  ServiceTabWidget({this.controller});
  @override
  _ServiceTabWidgetState createState() => _ServiceTabWidgetState(controller);
}

class _ServiceTabWidgetState extends State<ServiceTabWidget>
    with SingleTickerProviderStateMixin {
  ServiceTabBloc get serviceTabBloc => BlocProvider.of<ServiceTabBloc>(context);
  int currentTabIndex = 0;

  _ServiceTabWidgetState(ServicePageController _controller) {
    _controller.goBack = goBack;
  }
  void goBack() {
    _onTabTapped(currentTabIndex);
  }

  @override
  void initState() {
    super.initState();
    serviceTabBloc
        .add(ServiceTabChangedEvent(currentTabIndex: currentTabIndex));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<ServiceTabBloc, ServiceTabState>(
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
                      i < ServiceTabConstants.serviceTabs.length;
                      i++)
                    Tab(
                      text: ServiceTabConstants.serviceTabs[i].title,
                    ),
                ],
              ),
            ),
            if (state is ServiceTabLoading)
              Container(child: new Container(height: 400, child: AppLoading())),
            if (state is ServiceTabChanged)
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
                                          ? StringConst.sentence.NO_UP_SERVICES
                                          : state.currentTabIndex == 1
                                              ? StringConst
                                                  .sentence.NO_REQ_SERVICES
                                              : StringConst
                                                  .sentence.NO_PAST_SERVICES,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.subtitle1.copyWith(
                                          color: AppColors.noDataText),
                                    ),
                                  ),
                                  SpaceH24(),
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
                                        title: CommonButtons.BOOK_SERVICE),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
//                          NewRecord(
//                              title: CommonButtons.NEW_SERVICE,
//                              onTap: () {
//                                onBookPress();
//                              }),
                          ServicePageView(
                            appointments: state.appointments,
                            initialPage: state.currentTabIndex,
                          ),
                          SpaceH16()
                        ],
                      ),
                    ),
            // TabBarView(
            //   children: serviceTabConstants.serviceTabs
            //       .map<Widget>((e) => BlocProvider(
            //             create: (_) => serviceTabBloc,
            //             child: AppointmentPageView(
            //               appointments: state.appointments,
            //               initialPage: state.currentTabIndex,
            //             ),
            //           ))
            //       .toList(),
            // ),

            if (state is ServiceTabLoadError)
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
                                    ? StringConst.sentence.NO_UP_SERVICES
                                    : state.currentTabIndex == 1
                                        ? StringConst.sentence.NO_REQ_SERVICES
                                        : StringConst.sentence.NO_PAST_SERVICES,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.subtitle1
                                    .copyWith(color: AppColors.noDataText),
                              ),
                            ),
                            SpaceH24(),
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
                                  title: CommonButtons.BOOK_SERVICE),
                            ),
                          ],
                        )),
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
      serviceTabBloc.setIsLoading(true);
      serviceTabBloc.add(ServiceTabChangedEvent(currentTabIndex: index));
    } finally {
      serviceTabBloc.setIsLoading(false);
    }
  }

  void onBookPress() {
    ExtendedNavigator.root.push(Routes.bookServiceScreen).then(onGoBack);
    ;
  }

  Future<bool> onGoBack(dynamic value) async {
    _onTabTapped(currentTabIndex);
    return true;
  }
}
