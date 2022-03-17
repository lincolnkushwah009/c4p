import 'package:auto_route/auto_route.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/menu/bloc/drawer_bloc.dart';
import 'package:care4parents/presentation/screens/other/cubit/other_cubit.dart';

import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MenuItem {
  MenuItem(this.title,
      {this.iconData,
      this.onTap,
      this.header = false,
      this.selected = false,
      this.isLast = false,
      this.drawerSelection = DrawerItem.dashboard});

  final String title;
  final IconData iconData;
  final GestureTapCallback onTap;
  final bool selected;
  final bool header;
  final bool isLast;
  final DrawerItem drawerSelection;
}

class DrawerConstants {
  static List<MenuItem> menuList = [
    MenuItem(
      StringConst.DASHBOARD,
      header: true,
      onTap: () {},
      drawerSelection: DrawerItem.header,
    ),
    MenuItem(
      StringConst.HOME,
      iconData: Feather.home,
      onTap: () {
        // ExtendedNavigator.root.popUntil(ModalRoute.withName('/user_type_screen'));
        //Routes.HomeTypeScreen,
        // ExtendedNavigator.root.pushAndRemoveUntil(
        //     Routes.homeDashboardScreen,ModalRoute.withName('/user_type_screen')
        // );

        ExtendedNavigator.root.pushAndRemoveUntil(
          Routes.HomeTypeScreen,
          (route) => false,
        );
      },
      drawerSelection: DrawerItem.home,
    ),
    MenuItem(
      StringConst.DASHBOARD,
      iconData: Feather.heart,
      onTap: () {
        // ExtendedNavigator.root.popUntil(ModalRoute.withName('/user_type_screen'));
        //Routes.HomeTypeScreen,
        ExtendedNavigator.root.pushAndRemoveUntil(Routes.homeDashboardScreen,
            ModalRoute.withName('/user_type_screen'));
      },
      drawerSelection: DrawerItem.dashboard,
    ),
    MenuItem(
      StringConst.SERVICE_REQUESTS,
      iconData: Feather.bell,
      onTap: () {
        // ExtendedNavigator.root.push(
        //   Routes.serviceScreen,
        //
        // );

        ExtendedNavigator.root.pushAndRemoveUntil(
            Routes.serviceScreen, ModalRoute.withName('/user_type_screen'));
      },
      drawerSelection: DrawerItem.service_request,
    ),
    MenuItem(
      StringConst.MY_FAMILY,
      iconData: Feather.users,
      onTap: () {
        ExtendedNavigator.root.pushAndRemoveUntil(
            Routes.familyListScreen, ModalRoute.withName('/user_type_screen'));

        // ExtendedNavigator.root.push(
        //   Routes.familyListScreen,
        //
        // );
      },
      drawerSelection: DrawerItem.my_family,
    ),
    MenuItem(
      StringConst.ACTIVITY_REPORT,
      iconData: Feather.file_text,
      onTap: () {
        ExtendedNavigator.root.pushAndRemoveUntil(
            Routes.homeScreen, ModalRoute.withName('/user_type_screen'),
            arguments: HomeScreenArguments(tab: 1));

        // ExtendedNavigator.root.push(
        //     Routes.homeScreen,
        //     arguments: HomeScreenArguments(tab: 1));

        // ExtendedNavigator.root.push(Routes.activityReportScreen);
      },
      drawerSelection: DrawerItem.actives,
    ),
    MenuItem(
      StringConst.APPOINTMENT_SCREEN,
      iconData: Feather.calendar,
      onTap: () {
        // ExtendedNavigator.root.push(Routes.homeScreen);
        ExtendedNavigator.root
            .push(Routes.homeScreen, arguments: HomeScreenArguments(tab: 0));

        // ExtendedNavigator.root.pushAndRemoveUntil(
        //     Routes.homeScreen,ModalRoute.withName('/user_type_screen'),
        //     arguments: HomeScreenArguments(tab: 1)
        // );
      },
      drawerSelection: DrawerItem.valueAdded,
    ),
    MenuItem(
      StringConst.MEDICINE,
      iconData: Icons.medical_services,
      onTap: () {
        // ExtendedNavigator.root.pushAndRemoveUntil(
        //   Routes.medicineListScreen,
        //   (route) => false,
        // );

        // ExtendedNavigator.root.push(
        //   Routes.medicineListScreen,);

        ExtendedNavigator.root.pushAndRemoveUntil(Routes.medicineListScreen,
            ModalRoute.withName('/user_type_screen'));
      },
      drawerSelection: DrawerItem.medicine,
    ),
    MenuItem(
      StringConst.IMMUNIZATION,
      iconData: Feather.package,
      onTap: () {
        // ExtendedNavigator.root.push(
        //   Routes.immunizationListScreen,
        //
        // );

        ExtendedNavigator.root.pushAndRemoveUntil(Routes.immunizationListScreen,
            ModalRoute.withName('/user_type_screen'));
      },
      drawerSelection: DrawerItem.immunization,
    ),
    // MenuItem(
    //   StringConst.CONFERENCE,
    //   iconData:Icons.group,
    //   onTap: () {
    //     ExtendedNavigator.root.pushAndRemoveUntil(
    //       Routes.immunizationListScreen,
    //           (route) => false,
    //     );
    //   },
    //   drawerSelection: DrawerItem.immunization,
    // ),
    MenuItem(
      StringConst.INVOICE,
      iconData: Feather.book_open,
      onTap: () {
        // ExtendedNavigator.root.push(
        //   Routes.subscriptionListScreen,
        //
        // );

        ExtendedNavigator.root.pushAndRemoveUntil(Routes.subscriptionListScreen,
            ModalRoute.withName('/user_type_screen'));
      },
      drawerSelection: DrawerItem.subscription,
    ),
    MenuItem(
      StringConst.SETTINGS,
      iconData: Feather.settings,
      onTap: () {
        // ExtendedNavigator.root.push(
        //   Routes.settingScreen,
        //
        // );

        ExtendedNavigator.root.pushAndRemoveUntil(
            Routes.settingScreen, ModalRoute.withName('/user_type_screen'));
      },
      drawerSelection: DrawerItem.settings,
    ),

    MenuItem(
      StringConst.FAQ,
      iconData: Feather.help_circle,
      onTap: () {
        ExtendedNavigator.root.pushAndRemoveUntil(
            Routes.faqScreen, ModalRoute.withName('/user_type_screen'));

        // ExtendedNavigator.root.push(
        //   Routes.faqScreen,
        //
        // );
      },
      drawerSelection: DrawerItem.faq,
    ),
//    MenuItem(
//      StringConst.CONACT_US,
//      iconData: ImagePath.CONTACTS_ICON,
//      onTap: () {},
//      drawerSelection: DrawerItem.contacts,
//    ),
    MenuItem(
      StringConst.LOGOUT,
      iconData: Feather.log_out,
      onTap: () async {
        await SharedPreferenceHelper.removeTokenPref();
        await SharedPreferenceHelper.removeFamilyPref();
        await SharedPreferenceHelper.removeSubscriptionPref();
        await SharedPreferenceHelper.removeSelectedFamilyPref();
        await SharedPreferenceHelper.removeUserPref();
        await SharedPreferenceHelper.removeFamilyMermbersPref();
        ExtendedNavigator.root
            .pushAndRemoveUntil(Routes.userTypeScreen, (route) => false);
      },
      isLast: true,
      drawerSelection: DrawerItem.logout,
    ),
  ];
  static List<MenuItem> menuFamilyList = [
    MenuItem(
      StringConst.DASHBOARD,
      header: true,
      onTap: () {},
      drawerSelection: DrawerItem.header,
    ),
    MenuItem(
      StringConst.RECORD_VITALS,
      iconData: Feather.home,
      onTap: () {
        ExtendedNavigator.root
            .pushAndRemoveUntil(Routes.recordVitalScreen, (route) => false);
      },
      drawerSelection: DrawerItem.dashboard,
    ),
    MenuItem(
      StringConst.SETTINGS,
      iconData: Feather.settings,
      onTap: () {
        ExtendedNavigator.root
            .pushAndRemoveUntil(Routes.settingScreen, (route) => false);
      },
      drawerSelection: DrawerItem.settings,
    ),
    MenuItem(
      StringConst.FAQ,
      iconData: Feather.help_circle,
      onTap: () {
        ExtendedNavigator.root
            .pushAndRemoveUntil(Routes.faqScreen, (route) => false);
      },
      drawerSelection: DrawerItem.faq,
    ),
    MenuItem(
      StringConst.LOGOUT,
      iconData: Feather.log_out,
      onTap: () async {
        await SharedPreferenceHelper.removeTokenPref();
        await SharedPreferenceHelper.removeFamilyPref();
        Banners banners = await SharedPreferenceHelper.getBannersPref();
        if (banners != null && banners.whychoose.length > 0) {
          print('didChangeDependencies called');
          loadPictures1(banners.whychoose);
        }
        ExtendedNavigator.root.pushAndRemoveUntil(
            Routes.userTypeScreen, (route) => false,
            arguments: UserTypeScreenArguments(banners: banners));
      },
      // isLast: true,
      drawerSelection: DrawerItem.logout,
    ),
  ];
}

Future<void> loadPictures1(banners) async {
  for (String url in banners) {
    Future.wait([
      precacheImage(
        new NetworkImage(url),
        null,
      ),
    ]);
  }
}
