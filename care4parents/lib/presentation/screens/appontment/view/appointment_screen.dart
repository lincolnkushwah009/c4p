import 'package:auto_route/auto_route.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/appontment/bloc/appointment_tab_bloc.dart';
import 'package:care4parents/presentation/screens/appontment/view/appointment_tab_widget.dart';
import 'package:care4parents/presentation/screens/menu/bloc/drawer_bloc.dart';
import 'package:care4parents/presentation/screens/menu/view/menu_screen.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double kPadding = Sizes.PADDING_24;
const int _tabsLenght = 3;

class HomePageController {
  void Function() goBack;
}

class AppointmentScreen extends StatefulWidget {
  AppointmentScreen({Key key}) : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  AppointmentTabBloc appointmentTabBloc;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final HomePageController myController = HomePageController();

  @override
  void initState() {
    super.initState();
    appointmentTabBloc = getItInstance<AppointmentTabBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    appointmentTabBloc?.close();
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
          create: (context) => appointmentTabBloc,
        ),
      ],
      child: DefaultTabController(
        length: _tabsLenght,
        child: BlocBuilder<DrawerBloc, DrawerState>(
          builder: (context, state) {
            return Scaffold(
              key: scaffoldKey,
              drawer: MenuScreen(),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
                child: CustomAppBar(
                    title: StringConst.APPOINTMENT_SCREEN,
                    onLeadingTap: () => _openDrawer(),
                    trailing: [
                      InkWell(
                          onTap: () => {
                                ExtendedNavigator.root
                                    .push(Routes.bookAppointmentScreen)
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
                child: AppointmentTabWidget(
                  controller: myController,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }
}
