import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/activity_report/view/activity_screen.dart';
import 'package:care4parents/presentation/screens/appontment/appointment.dart';
import 'package:care4parents/presentation/screens/bottom_navigation/bottom_navigation.dart';
import 'package:care4parents/presentation/screens/dashboard/view/dashboard_screen.dart';
import 'package:care4parents/presentation/screens/menu/menu.dart';
import 'package:care4parents/presentation/screens/menu/view/menu_constant.dart';
import 'package:care4parents/presentation/screens/record_vital/view/record_vital_screen.dart';
import 'package:care4parents/presentation/screens/signup/view/signup_screen.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/values/values.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeDashboardScreen extends StatefulWidget {
  final int tab;
  HomeDashboardScreen({this.tab});

  @override
  _HomeScreenState createState() => _HomeScreenState(this.tab);
}

class _HomeScreenState extends State<HomeDashboardScreen> {
  DrawerBloc _drawerBloc;
  BottomNavigationBloc _bottomNavigationBloc;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int currentTabIndex = -1;
  _HomeScreenState(int tab) {
    this.currentTabIndex = tab != null ? tab : -1;
  }
  @override
  void initState() {
    super.initState();
    _drawerBloc = DrawerBloc();
    _bottomNavigationBloc = BottomNavigationBloc();
    _bottomNavigationBloc.add(PageTapped(index: currentTabIndex));
    // _content = _getContentForState(_bloc.state);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _drawerBloc,
        ),
        BlocProvider(
          create: (context) => _bottomNavigationBloc,
        ),
      ],
      child: BlocBuilder<DrawerBloc, DrawerState>(
        builder: (BuildContext context, DrawerState state) => Scaffold(
          // key: scaffoldKey,
          // drawer: MenuScreen(),
          // appBar: PreferredSize(
          //   preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
          //   child: CustomAppBar(
          //     hasTrailing: false,
          //     title: StringConst.APPOINTMENT_SCREEN,
          //     onLeadingTap: () => _openDrawer(),
          //   ),
          // ),
          body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
            // bloc: _bottomNavigationBloc,
            builder: (BuildContext context, BottomNavigationState state) {
              if (state is PageLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is DashboardPageLoaded) {
                return DashboardScreen();
              }
              if (state is AppointmentPageLoaded) {
                return AppointmentScreen();
              }
              if (state is ReportsPageLoaded) {
                return ActivityReportScreen();
                // return Container(child: Text('Report section'));
              }
              if (state is RecordVitalPageLoaded) {
                if (Platform.isIOS) {
                  return Container();
                  // return RecordVitalScreen();
                } else {
                  return RecordVitalScreen();
                }
              }
              return Container();
            },
          ),
          bottomNavigationBar:
              BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
                  // bloc: bottomNavigationBloc,
                  builder: (BuildContext context, BottomNavigationState state) {
            return FABBottomAppBar(
                centerItemText: '',
                color: AppColors.grey,
                index: currentTabIndex,
                selectedColor: AppColors.primaryColor,
                notchedShape: CircularNotchedRectangle(),
                onTabSelected: (index) =>
                    _bottomNavigationBloc.add(PageTapped(index: index)),
                items: [
                  for (var i = 0; i < BottomTabConstants.bottomTabs.length; i++)
                    FABBottomAppBarItem(
                        iconData: BottomTabConstants.bottomTabs[i].icon,
                        text: BottomTabConstants.bottomTabs[i].title),
                ]);
          }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFab(context),
        ),
      ),
    );
  }

  void _openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  Widget _buildFab(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      height: 100.0,
      width: 100.0,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            if (Platform.isIOS) {
            } else {
              ExtendedNavigator.root.push(Routes.recordVitalScreen);
            }
            // ExtendedNavigator.root.push(Routes.recordVitalScreen);
          },
          tooltip: 'Record Vitals',
          child: SvgPicture.asset(ImagePath.RECORD_VITAL_ICON),
          elevation: Sizes.ELEVATION_10,
        ),
      ),
    );
  }

  _getTextForItem(DrawerItem selectedItem) {
    String title;
    DrawerConstants.menuList.forEach((item) => {
          if (item.drawerSelection == selectedItem) {title = item.title}
        });
    return title;
  }
}
