import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/ImmunizationModel.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/user.dart';

import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/domain/entities/subscription.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/PurchagePlan_list/bloc/purchagePlan_list_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/vitaltype_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/view/family_list.dart';
import 'package:care4parents/presentation/screens/subscription_add/view/package_item.dart';

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

import 'PurchagePlanPackage_item.dart';



class PurchagePlanListScreen extends StatefulWidget {
  PurchagePlanListScreen({Key key}) : super(key: key);

  @override
  _MedicineListScreenState createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<PurchagePlanListScreen> {
  // ProfileBloc _profileBloc;
  PurchagePlanListBloc _purchagePlanListBloc;
  DrawerBloc _drawerBloc;
  DateFormat newFormat = DateFormat("yyyy-MM-dd");

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var isLoading = true;
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
    _purchagePlanListBloc = getItInstance<PurchagePlanListBloc>();
    _drawerBloc = getItInstance<DrawerBloc>();
    _purchagePlanListBloc.add(GetPackageLists());
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
          create: (context) => _purchagePlanListBloc,
        ),
        BlocProvider(
          create: (context) => _drawerBloc,
        ),
      ],
      child: BlocBuilder<DrawerBloc, DrawerState>(builder: (context, state) {
        return Scaffold(
            key: scaffoldKey,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
              child: CustomAppBar(
                  title: StringConst.Package,
                  leading: InkWell(
                    onTap: () => ExtendedNavigator.root.pop(),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  trailing: [
                    new whatappIconwidget(isHeader:true)

                  ],
                  hasTrailing: true
              ),
            ),
            body: GestureDetector(
              onTap: () {
                myController.methodA();
              },
              child: BlocBuilder<PurchagePlanListBloc, PurchagePlanListState>(
                  builder: (context, state) {
                if (state is ImmunizationLoading) return AppLoading();
                if (state is Loaded)
                  return Container(
                    child: (state.packageList?.isEmpty ?? true)
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(Sizes.PADDING_14),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    StringConst.sentence.No_Package,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.subtitle1
                                        .copyWith(color: AppColors.noDataText),
                                  ),
                                  SpaceH36(),

                                ],
                              ),
                            ),
                          )
                        : Container(
                      height: heightOfScreen*0.9,
                      child: new ListView.builder(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.packageList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new InkWell(
                            // splashColor: Colors.blueAccent,
                            onTap: () {
                              print("sonuuu");
                              setState(() {
                                state.packageList
                                    .forEach((element) => element.isSelected = false);
                                state.packageList[index].isSelected = true;
                              });
                              ExtendedNavigator.root
                                  .push(Routes.appointmentPayment,
                                  arguments: AppointmentPaymentArguments(

                                      appointment_id: 1,
                                      type:'purchagePlan',
                                      pckgitem:
                                      state.packageList[index]

                                  ))
                                  .then(onGoBack);

                            },
                            child: PackageItemPlan(item:state.packageList[index],
                                selectedPackageId:state.packageList[0].id,


                            onViewPackageClick:(){
                              setState(() {
                                if( state.packageList[index].isViewPackage){
                                  state. packageList
                                      .forEach((element) => element.isViewPackage = false);
                                }else{
                                  state. packageList
                                      .forEach((element) => element.isViewPackage = false);
                                  state.packageList[index].isViewPackage = true;
                                }



                              });

                            }
                            ),
                          );
                        },
                      ),
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
    );
  }




  void refreshData() {
    // _profileBloc.add(GetProfile());
  }

  Future<bool> onGoBack(dynamic value) async {
    refreshData();
    return true;
  }
}


