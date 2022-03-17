import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/domain/entities/subscription.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:care4parents/presentation/screens/settings/bloc/profile_bloc.dart';
import 'package:care4parents/presentation/screens/subscription_list/view/subscription_card_widget.dart';
import 'package:care4parents/presentation/widgets/app_error_widget.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/divider_widget.dart';
import 'package:care4parents/presentation/widgets/new_record.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:care4parents/presentation/screens/menu/bloc/drawer_bloc.dart';
import 'package:care4parents/presentation/screens/menu/view/menu_screen.dart';
import 'family_card_widget.dart';

class FamilyListScreen extends StatefulWidget {
  FamilyListScreen({Key key}) : super(key: key);

  @override
  _FamilyListScreenState createState() => _FamilyListScreenState();
}

class _FamilyListScreenState extends State<FamilyListScreen> {
  DashboardBloc _dashboardBloc;
  DrawerBloc _drawerBloc;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _dashboardBloc = getItInstance<DashboardBloc>();
    _drawerBloc = getItInstance<DrawerBloc>();
    _dashboardBloc.add(GetFamilyList());
  }

  void _openDrawer() {
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
          create: (context) => _dashboardBloc,
        ),
        BlocProvider(
          create: (context) => _drawerBloc,
        ),
      ],
      child: BlocBuilder<DrawerBloc, DrawerState>(builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          drawer: MenuScreen(),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
            child: CustomAppBar(
                onLeadingTap: () => _openDrawer(),
                title: StringConst.MY_FAMILY,
                trailing: [
                  InkWell(
                      onTap: () => {goToSubscription()},
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.add_circle_outline,
                          size: Sizes.dimen_12.h,
                          color: AppColors.white,
                        ),
                      )),
                  new whatappIconwidget(isHeader: true)
                ],
                hasTrailing: true),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
//              SpaceH12(),
//              NewRecord(
//                  title: CommonButtons.ADD_FAMILY_MEMBER,
//                  onTap: () {
//                    goToSubscription();
//                  }),
              BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is PageLoading)
                    return new Container(
                      height: 400,
                      child: AppLoading(),
                    );
                  if (state is LoadedFamilyList &&
                      state.userList != null &&
                      state.userList.length > 0) {
                    return Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.userList.length + 1,
                            itemBuilder: (context, index) {
                              if (index == state.userList.length) {
                                return SizedBox(height: 50);
                              } else {
                                FamilyMainResult family = state.userList[index];
                                return GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: Sizes.MARGIN_10),
                                    child: FamilyCardWidget(
                                        id: family.id,
                                        name: family.family_member.name,
                                        credits: family.family_member.credits,
                                        relation: family.family_member.relation,
                                        gender: family.family_member.gender,
                                        phone: (family.family_member.phone !=
                                                    null &&
                                                family.family_member.phone
                                                    .startsWith('91'))
                                            ? family.family_member.phone
                                                .substring(
                                                    2,
                                                    family.family_member.phone
                                                        .length)
                                            : family.family_member.phone,
                                        family_member: family.family_member),
                                  ),
                                  onTap: () {
                                    // print("package"+family.packageData[0].code.toString());
                                    // print("family"+family.toString());
                                    goToMemberProfile(family);
                                  },
                                );
                              }
                            }));
                  }
                  if (state is PageLoading) {
                    return new Container(
                      height: 400,
                      child: AppLoading(),
                    );
                  } else {
                    return Expanded(
                        child: Center(child: Text('No family member found.')));
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  void refreshData() {
    // _profileBloc.add(GetProfile());
    _dashboardBloc.add(GetFamilyList());
  }

  Future<bool> onGoBack(dynamic value) async {
    refreshData();
    return true;
  }

  void goToSubscription() {
    print('subscriptionAddScreen');
    ExtendedNavigator.root.push(Routes.subscriptionAddScreen).then(onGoBack);
  }

  void goToMemberProfile(member) {
    print("member" + member.toString());
    ExtendedNavigator.root
        .push(
          Routes.memberProfileScreen,
          arguments: MemberProfileScreenArguments(member: member),
        )
        .then(onGoBack);
  }
}

// void goToMemberProfile(member) {
//   ExtendedNavigator.root
//       .push(
//         Routes.memberProfileScreen,
//         arguments: MemberProfileScreenArguments(member: member),
//       )
//       .then(onGoBack);
// }

// class FamilyListTile extends StatelessWidget {
//   final List<FamilyMainResult> data;
//   const FamilyListTile({Key key, @required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         shrinkWrap: true,
//         itemCount: data.length + 1,
//         itemBuilder: (context, index) {
//           if (index == data.length) {
//             return SizedBox(height: 50);
//           } else {
//             FamilyMainResult family = data[index];
//             return GestureDetector(
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_10),
//                 child: FamilyCardWidget(
//                     id: family.id,
//                     name: family.family_member.name,
//                     relation: family.family_member.relation,
//                     gender: family.family_member.gender,
//                     phone: family.family_member.phone,
//                     family_member: family.family_member),
//               ),
//               onTap: () {
//                 goToMemberProfile(family);
//               },
//             );
//           }
//         });
//   }
// }
