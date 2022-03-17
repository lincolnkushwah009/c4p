import 'package:auto_route/auto_route.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/appontment/bloc/appointment_tab_bloc.dart';
import 'package:care4parents/presentation/screens/appontment/view/appointment_tab_widget.dart';
import 'package:care4parents/presentation/screens/bottom_navigation/bottom_navigation.dart';
import 'package:care4parents/presentation/screens/menu/menu.dart';
import 'package:care4parents/presentation/screens/menu/view/menu_screen.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../service.dart';
import 'service_tab_widget.dart';

const double kPadding = Sizes.PADDING_24;
const int _tabsLenght = 3;

class ServicePageController {
  void Function() goBack;
}

class ServiceScreen extends StatefulWidget {
  ServiceScreen({Key key}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final ServicePageController myController = ServicePageController();

  ServiceTabBloc serviceTabBloc;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  BottomNavigationBloc _bottomNavigationBloc;
  DrawerBloc _drawerBloc;
  int currentTabIndex = 0;
  @override
  void initState() {
    super.initState();
    serviceTabBloc = getItInstance<ServiceTabBloc>();
    _drawerBloc = getItInstance<DrawerBloc>();
    _bottomNavigationBloc = BottomNavigationBloc();
    _bottomNavigationBloc.add(PageTapped(index: currentTabIndex));
  }

  @override
  void dispose() {
    super.dispose();
    serviceTabBloc?.close();
  }

  Future<bool> onGoBack(dynamic value) async {
    // _onTabTapped(currentTabIndex);
    myController.goBack();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceTabBloc,
        ),
        BlocProvider(
          create: (context) => _bottomNavigationBloc,
        ),
        BlocProvider(
          create: (context) => _drawerBloc,
        ),
      ],
      child: DefaultTabController(
          length: _tabsLenght,
          child:
              BlocBuilder<DrawerBloc, DrawerState>(builder: (context, state) {
            return Scaffold(
              key: scaffoldKey,
              drawer: MenuScreen(),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
                child: CustomAppBar(
                    title: StringConst.SERVICE_REQUESTS,
                    onLeadingTap: () => _openDrawer(),
                    trailing: [
                      InkWell(
                          onTap: () => {
                                ExtendedNavigator.root
                                    .push(Routes.bookServiceScreen)
                                    .then(onGoBack),
                              },
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.add_circle_outline,
                              size: Sizes.dimen_12.h,
                              color: AppColors.white,
                            ),
                          )),
                      new whatappIconwidget(isHeader:true)
                    ],
                    hasTrailing: true),
              ),
              body: Padding(
                padding: const EdgeInsets.only(
                    top: Sizes.PADDING_2,
                    left: Sizes.PADDING_10,
                    right: Sizes.PADDING_10,
                    bottom: Sizes.PADDING_24),
                child: ServiceTabWidget(
                  controller: myController,
                ),
              ),
            );
          })),
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
            ExtendedNavigator.root.push(Routes.recordVitalScreen);
          },
          tooltip: 'Record Vitals',
          child: SvgPicture.asset(ImagePath.RECORD_VITAL_ICON),
          elevation: Sizes.ELEVATION_10,
        ),
      ),
    );
  }
}
