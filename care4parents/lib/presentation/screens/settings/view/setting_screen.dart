import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/settings/bloc/profile_bloc.dart';
import 'package:care4parents/presentation/widgets/app_error_widget.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/divider_widget.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:care4parents/presentation/screens/menu/menu.dart';

class SettingSubItem {
  SettingSubItem({
    @required this.subtitle,
    this.textColor,
    this.routeName,
  });

  final String subtitle;
  final Color textColor;
  final String routeName;
}

class SettingItem {
  SettingItem({
    @required this.title,
    this.subitems,
  });

  final String title;
  final List<SettingSubItem> subitems;
}

List<SettingItem> settingItems = [
  SettingItem(title: StringConst.sentence.ACCOUNT_SETTING, subitems: [
    SettingSubItem(
      subtitle: StringConst.sentence.PROFILE,
      textColor: AppColors.greyShade3,
      routeName: Routes.profileScreen,
    ),
    SettingSubItem(
      subtitle: StringConst.sentence.CHANGE_PASSWORD,
      textColor: AppColors.greyShade3,
      routeName: Routes.changePasswordScreen,
    )
  ]),
  SettingItem(title: StringConst.sentence.SUPPORT, subitems: [
    SettingSubItem(
      subtitle: StringConst.sentence.TERMS_CONDITIONS,
      textColor: AppColors.greyShade3,
      routeName: Routes.tearmsScreen,
    ),
    SettingSubItem(
      subtitle: StringConst.sentence.PRIVACY_POLICY,
      textColor: AppColors.greyShade3,
      routeName: Routes.privacyScreen,
    )
  ]),
];

List<SettingItem> familySettingItems = [
  // SettingItem(title: StringConst.sentence.ACCOUNT_SETTING, subitems: [
  //   SettingSubItem(
  //     subtitle: StringConst.sentence.PROFILE,
  //     textColor: AppColors.greyShade3,
  //     routeName: Routes.profileScreen,
  //   ),
  //   SettingSubItem(
  //     subtitle: StringConst.sentence.CHANGE_PASSWORD,
  //     textColor: AppColors.greyShade3,
  //     routeName: Routes.changePasswordScreen,
  //   )
  // ]),
  SettingItem(title: StringConst.sentence.SUPPORT, subitems: [
    SettingSubItem(
      subtitle: StringConst.sentence.TERMS_CONDITIONS,
      textColor: AppColors.greyShade3,
      routeName: Routes.tearmsScreen,
    ),
    SettingSubItem(
      subtitle: StringConst.sentence.PRIVACY_POLICY,
      textColor: AppColors.greyShade3,
      routeName: Routes.privacyScreen,
    )
  ]),
];

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ProfileBloc _profileBloc;
  DrawerBloc _drawerBloc;
  FamilyMember member;
  User user;
  var isLoading = true;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    asyncSharePref();
    _profileBloc = getItInstance<ProfileBloc>();
    _drawerBloc = getItInstance<DrawerBloc>();
    _profileBloc.add(GetProfile());
  }

  void asyncSharePref() async {
    // await SharedPreferenceHelper.setUserPref(null);

    member = await SharedPreferenceHelper.getFamilyPref();
    user = await SharedPreferenceHelper.getUserPref();
    print(member);
    print(user);
    if (member != null || user != null) {
      // print('member >>>>>>>>>>>>' + member.toString());
      print('user >>>>>>>>>>>>>' + user.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  void _openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    if (user != null && user.profilephoto != null) {
      print(' user.profilephoto' + user.profilephoto);
    }
    ThemeData theme = Theme.of(context);
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _profileBloc,
        ),
        BlocProvider(
          create: (context) => _drawerBloc,
        )
      ],
      child: BlocBuilder<DrawerBloc, DrawerState>(builder: (context, state) {
        return Scaffold(
            key: scaffoldKey,
            drawer: MenuScreen(isFamily: member != null ? true : false),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
              child: CustomAppBar(
                  onLeadingTap: () => _openDrawer(),
                  title: StringConst.SETTING_SCREEN,
                  trailing: [
                    new whatappIconwidget(isHeader:true)

                  ],
                  hasTrailing: true),
            ),
            body: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                user != null
                    ? TopProfile(
                        widthOfScreen: widthOfScreen,
                        heightOfScreen: heightOfScreen,
                        theme: theme,
                        user: user)
                    : Container(),
                BgCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.PADDING_8,
                    vertical: Sizes.PADDING_8,
                  ),
                  width: widthOfScreen,
                  height: heightOfScreen * 0.7,
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(Sizes.RADIUS_10),
                  ),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: member != null
                            ? familySettingItems.length
                            : settingItems.length,
                        itemBuilder: (context, index) {
                          SettingItem item = member != null
                              ? familySettingItems[index]
                              : settingItems[index];
                          return Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: Sizes.PADDING_14,
                                    left: Sizes.PADDING_16,
                                  ),
                                  child: Text(item.title,
                                      style: theme.textTheme.subtitle2.copyWith(
                                        fontWeight: FontWeight.w900,
                                      )),
                                ),
                                buildVerticalList(item.subitems),
                                // DividerGrey()
                              ],
                            ),
                          );
                        },
                      ),
                      SpaceH8(),
                      InkWell(
                        onTap: () {
                          _onLogout();
                        },
                        child: Text(CommonButtons.SIGNOUT,
                            style: theme.textTheme.blueHeadline6),
                      ),
                      SpaceH16()
                    ],
                  ),
                ),
              ],
            ));
      }),
    );
  }

  Widget buildVerticalList(List<SettingSubItem> subitems) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: subitems.length,
      itemBuilder: (context, index) {
        return renderItem(subitems[index]);
      },
    );
  }

  void refreshData() {
    _profileBloc.add(GetProfile());
  }

  Future<bool> onGoBack(dynamic value) async {
    refreshData();
    return true;
  }

  renderItem(item) {
    return new BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (item.routeName != null) {
              if (item.routeName == Routes.homeScreen) {
                ExtendedNavigator.root.pop();
              } else {
                if (state is ProfileLoaded &&
                    item.routeName == Routes.profileScreen) {
                  ExtendedNavigator.root
                      .push(
                        Routes.profileScreen,
                        arguments: ProfileScreenArguments(user: state.user),
                      )
                      .then(onGoBack);
                } else {
                  ExtendedNavigator.root.push(item.routeName);
                }
              }
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_14),
            height: Sizes.HEIGHT_36,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  vertical: -Sizes.PADDING_2, horizontal: Sizes.PADDING_10),
              title: new Text(item.subtitle,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: AppColors.secodaryText,
                      )),
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: Sizes.ICON_SIZE_16),
            ),
          ),
        );
      },
    );
  }

  // @override
  // Widget wrappedRoute(BuildContext context) {
  //   return BlocProvider(create: (ctx) => _profileBloc, child: this);
  // }
}

Future<void> _onLogout() async {
  await SharedPreferenceHelper.setUserPref(null);
  await SharedPreferenceHelper.setTokenPref(null);
  await SharedPreferenceHelper.setFamilyPref(null);
  await SharedPreferenceHelper.setSubscriptionPref(null);
  await SharedPreferenceHelper.setSelectedFamilyPref(null);
  await SharedPreferenceHelper.setFamilyMermbersPref(null);

  ExtendedNavigator.root
      .pushAndRemoveUntil(Routes.userTypeScreen, (route) => false);
}

class TopProfile extends StatelessWidget {
  const TopProfile(
      {Key key,
      @required this.widthOfScreen,
      @required this.heightOfScreen,
      @required this.theme,
      @required this.user})
      : super(key: key);

  final double widthOfScreen;
  final double heightOfScreen;
  final ThemeData theme;
  final User user;

  @override
  Widget build(BuildContext context) {
    if (user != null && user.profilephoto != null)
      print('user.profilephoto >>>>>>>>>>>>>>>>>>>>>>>' + user.profilephoto);

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          print(
              'ProfileLoaded called 8888888888888888888888888888888888888888' +
                  state.user.toString());
          final User user = state.user;
          return BgCard(
            padding: EdgeInsets.zero,
            width: widthOfScreen,
            height: heightOfScreen * 0.26,
            borderRadius: const BorderRadius.all(
              const Radius.circular(Sizes.RADIUS_10),
            ),
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // if (state is ProfileLoaded)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpaceH12(),
                      ClipOval(
                          child: CircularProfileAvatar(
                        user.profilephoto != null && user.profilephoto != ""
                            ? '${StringConst.BASE_URL}' + user.profilephoto
                            : "", //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                        radius: 50, // sets radius, default 50.0
                        backgroundColor: Colors
                            .transparent, // sets background color, default Colors.white
                        borderWidth: 1, // sets border, default 0.0
                        initialsText: Text(
                          user.name.characters.first,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ), // sets initials text, set your own style, default Text('')
                        borderColor: AppColors
                            .primaryColor, // sets border color, default Colors.white
                        elevation:
                            4.0, // sets elevation (shadow of the profile picture), default value is 0.0
                        foregroundColor: AppColors.primaryColor.withOpacity(
                            0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                        // cacheImage:
                        //     true, // allow widget to cache image against provided url
                        // // sets on tap
                        // showInitialTextAbovePicture:
                        //     false, // setting it true will show initials text above profile picture, default false
                      )),
                      SpaceH8(),
                      Text(
                        user.name.capitalize(),
                        style: theme.textTheme.subtitle1.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ]),
          );
        } else {
          return BgCard(
            padding: EdgeInsets.zero,
            width: widthOfScreen,
            height: heightOfScreen * 0.26,
            borderRadius: const BorderRadius.all(
              const Radius.circular(Sizes.RADIUS_10),
            ),
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // if (state is ProfileLoaded)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpaceH12(),
                      ClipOval(
                          child: CircularProfileAvatar(
                        user.profilephoto != null && user.profilephoto != ""
                            ? '${StringConst.BASE_URL}' + user.profilephoto
                            : "", //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                        radius: 50, // sets radius, default 50.0
                        backgroundColor: Colors
                            .transparent, // sets background color, default Colors.white
                        borderWidth: 1, // sets border, default 0.0
                        initialsText: Text(
                          user.name.characters.first,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ), // sets initials text, set your own style, default Text('')
                        borderColor: AppColors
                            .primaryColor, // sets border color, default Colors.white
                        elevation:
                            4.0, // sets elevation (shadow of the profile picture), default value is 0.0
                        foregroundColor: AppColors.primaryColor.withOpacity(
                            0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                        // cacheImage:
                        //     true, // allow widget to cache image against provided url
                        // // sets on tap
                        // showInitialTextAbovePicture:
                        //     false, // setting it true will show initials text above profile picture, default false
                      )),
                      SpaceH8(),
                      Text(
                        user.name.capitalize(),
                        style: theme.textTheme.subtitle1.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ]),
          );
        }
      },
    );
  }
}
