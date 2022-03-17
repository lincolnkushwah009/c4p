import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/activity_report/bloc/activity_tab_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/vitaltype_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/view/family_list.dart';
import 'package:care4parents/presentation/screens/menu/bloc/drawer_bloc.dart';
import 'package:care4parents/presentation/screens/menu/view/menu_screen.dart';
import 'package:care4parents/presentation/screens/my_family/view/my_family_screen.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../activity_report.dart';
import 'activity_tab_widget.dart';

const double kPadding = Sizes.PADDING_24;
const int _tabsLenght = 3;

class ActivityReportController {
  void Function() refesh;
}

class ActivityReportScreen extends StatefulWidget {
  ActivityReportScreen({Key key}) : super(key: key);

  @override
  _ActivityReportScreenState createState() => _ActivityReportScreenState();
}

class _ActivityReportScreenState extends State<ActivityReportScreen> {
  final ActivityReportController aRController = ActivityReportController();

  ActivityTabBloc _activityTabBloc;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var isLoading = true;
  DashboardBloc _dashboardBloc;
  FamilyMember member;
  final HomePageController myController = HomePageController();
  User user;
  String _mobile;
  @override
  void initState() {
    super.initState();
    _activityTabBloc = getItInstance<ActivityTabBloc>();
    _dashboardBloc = getItInstance<DashboardBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    // Activity?.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _activityTabBloc,
        ),
        BlocProvider(
          lazy: false,
          create: (context) => _dashboardBloc
            ..add(
              GetFamilyList(),
            ),
        ),
      ],
      child: DefaultTabController(
        initialIndex: 1,
        length: _tabsLenght,
        child: BlocBuilder<DrawerBloc, DrawerState>(
          builder: (context, state) {
            return Scaffold(
                key: scaffoldKey,
                drawer: MenuScreen(),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
                  child: CustomAppBar(
                      title: StringConst.ACTIVITY_REPORT_SCREEN,
                      onLeadingTap: () => _openDrawer(),
                      trailing: [
                        InkWell(
                            onTap: () => {
                                  ExtendedNavigator.root.push(
                                      Routes.reportDetailScreen,
                                      arguments: ReportDetailScreenArguments(
                                          // vitalVals: vitalVals,
                                          isSearch: true)),
                                },
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.search,
                                size: Sizes.dimen_12.h,
                                color: AppColors.white,
                              ),
                            )),
                        BlocBuilder<DashboardBloc, DashboardState>(
                          builder: (context, state) {
                            if ((state is LoadedFamilyList) &&
                                state.userList != null &&
                                state.userList.length > 0) {
                              return Container(
                                  child: FamilyMemberList(
                                controller: myController,
                                userFamily: state.userList,
                                selectedId: state.selectedId,
                                onChange: (index) async {
                                  await context.read<DashboardBloc>().add(
                                      UpdateSelectedFamilyMemberId(
                                          state.userList[index],
                                          state.userList[index].family_member
                                              .id));
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    aRController.refesh();
                                  });
                                  // context.read<VitaltypeBloc>().add(GetListTypes(
                                  //     state.userList[index].family_member.phone));
                                  // _mobile =
                                  //     state.userList[index].family_member.phone;
                                },
                              ));
                            }

                            {
                              return Container();
                            }
                          },
                        ),
                        new whatappIconwidget(isHeader:true)
                      ],
                      hasTrailing: true),
                ),
                body: GestureDetector(
                  onTap: () {
                    if (myController != null) myController.methodA();
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: (Sizes.PADDING_2).h,
                          horizontal: (Sizes.PADDING_8).w),
                      child: ActivityTabWidget(
                          aRController: aRController, currentTabIndex: 1),
                    ),
                  ),
                ),
                floatingActionButton: new Container(
                  height: 45.0,
                  margin: EdgeInsets.only(bottom: 50.0),
                  child: new Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomRight,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: 45.0,
                              child: new FloatingActionButton.extended(
                                heroTag: "btn1",
                                onPressed: () => {
                                  ExtendedNavigator.root
                                      .push(Routes.uploadScreen)
                                      .then(onGoBack)
                                },
                                tooltip: 'Upload Report',
                                label: new Text('Upload Report',
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(
                                          color: AppColors.white,
                                        )),
                                icon: Icon(
                                  Icons.upload_file, color: AppColors.white,
                                  // color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }

  void _openDrawer() {
    if (myController.methodA != null) myController.methodA();

    scaffoldKey.currentState.openDrawer();
  }

  Future<bool> onGoBack(dynamic value) async {
    aRController.refesh();
    // _onTabTapped(currentTabIndex);
    // myController.goBack();
    return true;
  }
}
