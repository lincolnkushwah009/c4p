import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/widgets/logo_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:flutter/material.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'other/cubit/other_cubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  OtherCubit _otherCubit;
  Banners banners;
  @override
  void initState() {
    _otherCubit = getItInstance<OtherCubit>();
    _otherCubit.getPage('banners');


    run();

    super.initState();
  }

//  Future<void> loadPictures() async {
//    Future.wait([
//      precachePicture(
//        ExactAssetPicture(SvgPicture.svgStringDecoder, ImagePath.ONBOADING1),
//        null,
//      ),
//      precachePicture(
//        ExactAssetPicture(SvgPicture.svgStringDecoder, ImagePath.ONBOADING2),
//        null,
//      ),
//      precachePicture(
//        ExactAssetPicture(SvgPicture.svgStringDecoder, ImagePath.ONBOADING3),
//        null,
//      ),
//      // other SVGs or images here
//    ]);
//  }

  void run() async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();

//
//    AndroidDeviceInfo iosInfo = await deviceInfo.androidInfo;
//
//    print(iosInfo.id);
//    print(iosInfo.display);
//    print(iosInfo.device);

    User userData = await SharedPreferenceHelper.getUserPref();
    FamilyMember familyData = await SharedPreferenceHelper.getFamilyPref();
    String token = await SharedPreferenceHelper.getTokenPref();
    bool isFirstLoad =true;// await SharedPreferenceHelper.getIsFirstLoadPref();
    if (familyData != null && token != null) {
      print('familyData ===== $familyData');
      print('token ===== $token');
      Future.delayed(Duration(milliseconds: 1500), () {
        ExtendedNavigator.root
            .pushAndRemoveUntil(Routes.recordVitalScreen, (route) => false);
      });
    } else if (userData != null && token != null) {

      print('userData ===== $userData');
      print('token ===== $token');

      Future.delayed(Duration(milliseconds: 1500), () {
        ExtendedNavigator.root
            .pushAndRemoveUntil(Routes.HomeTypeScreen, (route) => false);
      });

    } else if (!isFirstLoad) {
      Future.delayed(Duration(milliseconds: 1500), () {
        ExtendedNavigator.root
            .pushAndRemoveUntil(Routes.onBoardingScreen, (route) => false);
      });
    } else {

      await Future.delayed(Duration(milliseconds: 3500), ()  async{
        banners = await SharedPreferenceHelper.getBannersPref();
        if (banners != null && banners.whychoose.length > 0) {
          print('didChangeDependencies called');
          // loadPictures1(banners.whychoose);
        }
        print('banners =====>' + banners.toString());
        ExtendedNavigator.root.pushAndRemoveUntil(
            Routes.userTypeScreen, (route) => false,
            arguments: UserTypeScreenArguments(banners: banners));
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Future<void> loadPictures1(banners) async {
  //   for (String url in banners) {
  //     Future.wait([
  //       precacheImage(
  //         new NetworkImage(url),
  //         null,
  //       ),
  //     ]);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        width: widthOfScreen,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: (heightOfScreen * 0.1)),
                child: Logo(widthOfScreen: widthOfScreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
