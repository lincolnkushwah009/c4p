import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/ImmunizationModel.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/user.dart';

import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/domain/entities/subscription.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/Immunization_list/bloc/immunization_list_bloc.dart';
import 'package:care4parents/presentation/screens/Immunization_list/view/immunization_card_widget.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/vitaltype_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/view/family_list.dart';

import 'package:care4parents/presentation/widgets/app_loading.dart';

import 'package:care4parents/presentation/widgets/custom_app_bar.dart';

import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:care4parents/presentation/screens/menu/menu.dart';

class ImmunizationListScreen extends StatefulWidget {
  ImmunizationListScreen({Key key}) : super(key: key);

  @override
  _MedicineListScreenState createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<ImmunizationListScreen> {
  // ProfileBloc _profileBloc;
  ImmunizationListBloc _immunizationListBloc;
  DrawerBloc _drawerBloc;
  DateFormat newFormat = DateFormat("yyyy-MM-dd");

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var isLoading = true;
  DashboardBloc _dashboardBloc;
  FamilyMember member;
  final HomePageController myController = HomePageController();
  User user;
  String _mobile;
  // List<Subscription> subscriptions = [
  //   Subscription(
  //       id: 1354,
  //       name: 'John',
  //       subscription_date: '2021-04-12',
  //       package: 'Gold',
  //       amount: "200"),
  //   Subscription(
  //       id: 354,
  //       name: 'John1',
  //       subscription_date: '2021-04-01',
  //       package: 'Gold',
  //       amount: "200")
  // ];

  @override
  void initState() {
    super.initState();
    _immunizationListBloc = getItInstance<ImmunizationListBloc>();
    _drawerBloc = getItInstance<DrawerBloc>();
    _immunizationListBloc.add(GetImmunization());
    _dashboardBloc = getItInstance<DashboardBloc>();
  }

  void _openDrawer() {
    if (myController.methodA != null) myController.methodA();
    scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _immunizationListBloc,
          ),
          BlocProvider(
            create: (context) => _drawerBloc,
          ),
          BlocProvider(
            lazy: false,
            create: (context) => _dashboardBloc
              ..add(
                GetFamilyList(),
              ),
          ),
        ],
        child: BlocListener<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is FamilyLoadError) {
              _immunizationListBloc.add(GetImmunization());
            }
            if (state is LoadedFamilyList) {
              // if (state.userList.length > 0)
              //   context
              //       .read<VitaltypeBloc>()
              //       .add(GetListTypes(state.userList[0].family_member.phone));

              // _mobile = state.userList[0].family_member.phone;
            }
          },
          child:
              BlocBuilder<DrawerBloc, DrawerState>(builder: (context, state) {
            return Scaffold(
                key: scaffoldKey,
                drawer: MenuScreen(),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
                  child: CustomAppBar(
                      onLeadingTap: () => _openDrawer(),
                      title: StringConst.IMMUNIZATION,
                      trailing: [
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
                                onChange: (index) {
                                  context.read<DashboardBloc>().add(
                                      UpdateSelectedFamilyMemberId(
                                          state.userList[index],
                                          state.userList[index].family_member
                                              .id));
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    _immunizationListBloc
                                        .add(GetImmunization());
                                  });

                                  // context.read<VitaltypeBloc>().add(
                                  //     GetListTypes(state.userList[index]
                                  //         .family_member.phone));
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
                    myController.methodA();
                  },
                  child:
                      BlocBuilder<ImmunizationListBloc, ImmunizationListState>(
                          builder: (context, state) {
                    if (state is ImmunizationLoading) return AppLoading();
                    if (state is Loaded)
                      return Container(
                        child: (state.invoices?.isEmpty ?? true)
                            ? Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.all(Sizes.PADDING_14),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        StringConst.sentence.No_Immunization,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.subtitle1
                                            .copyWith(
                                                color: AppColors.noDataText),
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
                                  ),
                                ),
                              )
                            : ListView(
                                // physics: BouncingScrollPhysics(),
                                children: [
                                  ..._buildSubscriptionListTile(
                                      context: context, data: state.invoices)
                                ],
                              ),
                      );
                    if (state is LoadError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(Sizes.PADDING_14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                StringConst.sentence.No_Immunization,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.subtitle1
                                    .copyWith(color: AppColors.noDataText),
                              ),
                              SpaceH36(),
                            ],
                          ),
                        ),
                      );
                    }

                    return Container();
                  }),
                ));
          }),
        ));
  }

  void _launchURL(url)  =>{
    ExtendedNavigator.root.push(Routes.PdfViewer,
        arguments: PdfViewScreenArguments(
          pdfUrl:url, )
    )

  };
  List<Widget> _buildSubscriptionListTile(
      {@required BuildContext context,
      @required List<ImmunizationData> data,
      @required Theme theme}) {
    List<Widget> items = [];
    TextTheme textTheme = Theme.of(context).textTheme;

    for (int index = 0; index < data.length; index++) {
      ImmunizationData sub = data[index];
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(sub.startDate);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputDate = newFormat.format(inputDate);

      items.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_10),
          child: ImmunizationCardWidget(
              name: sub.name != null && sub.name != null ? sub.name : '',
              route: sub.route != null && sub.route != "" ? sub.route : '',
              startDate: sub.startDate != null && sub.startDate != ""
                  ? outputDate
                  : '',
              endDate: "",
              remarks:
                  sub.remarks != null && sub.remarks != "" ? sub.remarks : '',
              openlink: () {
                print("prescriptionFile>> " + sub.prescriptionFile);
                _launchURL(sub.prescriptionFile);
              },
              prescription_file: sub.prescriptionFile),
        ),
      );
    }

    return items;
  }

  void refreshData() {
    // _profileBloc.add(GetProfile());
  }

  Future<bool> onGoBack(dynamic value) async {
    refreshData();
    return true;
  }
}

void goToSubscription() {
  ExtendedNavigator.root.push(Routes.subscriptionAddScreen);
}
