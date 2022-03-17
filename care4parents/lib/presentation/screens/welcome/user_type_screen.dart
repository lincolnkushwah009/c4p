import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/other/cubit/other_cubit.dart';
import 'package:care4parents/presentation/screens/welcome/Data.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/logo_widget.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/util/SizeConfig.dart';
import 'package:care4parents/values/values.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

const double kPadding = Sizes.PADDING_14;

class UserTypeScreen extends StatefulWidget {
  final Banners banners;
  const UserTypeScreen({Key key, this.banners}) : super(key: key);

  @override
  _UserTypeScreenState createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  Banners banners;
  @override
  void initState() {
    super.initState();
    asyncSharePref();
readLocal();
    // _otherCubit = getItInstance<OtherCubit>();
    // _otherCubit.getPage('banners');
  }


  readLocal() async  {
    print("xsdf>> sonu jjjj ");

    FirebaseDatabase.instance
        .ref().once().then((value){
            print(' ppp  Connected to second database and read ${value.snapshot.value}');
//      var data = snapshot.value;
//      print("xsdf>> "+snapshot.value);

      if (value.snapshot.value!=null) {
        var user = Data.fromfcmVersionJson(value.snapshot.value);
         parseappversionbyfcm(user);


      }
        }).onError((error, stackTrace){});
  }

  int force_update = 0,isShowAppUpdate=1;
  String downloadingStr = "",headerMsg="",
      appUpdateMsg = "Would you like to update?";
  parseappversionbyfcm(user) async{

    if (Platform.isIOS) {
      int version_code = user.iosversion;
      force_update = user.iosForceupdate;
      print("force_update>> "+force_update.toString());
      print("version_code>> "+version_code.toString());
      appUpdateMsg = user.message;
      headerMsg=user.headermsg;
      isShowAppUpdate=user.show_updateios;

      if(isShowAppUpdate==1){
        //force_update = 0;
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        int app_version_code = int.parse(packageInfo.buildNumber);
        print("app_version_code>> "+app_version_code.toString());
        if (app_version_code == version_code) {
          force_update = 0;
        } else if (force_update == 1) {
          _onAlertWithStylePressed2(
            context,
          );
        } else if (app_version_code < version_code) {
          _onAlertWithStylePressed2(
            context,
          );
        }
      }else{
        appUpdateMsg = user.updatemsg;
        headerMsg="";
//    _onAlertWithStylePressed2(
//      context,
//    );
      }
    }else{


      int version_code = user.version_code;
      force_update = user.force_update;
      print("force_update>> "+force_update.toString());
      print("version_code>> "+version_code.toString());
      appUpdateMsg = user.message;
      headerMsg=user.headermsg;
      isShowAppUpdate=user.isShowAppUpdate;

      if(isShowAppUpdate==1){
        //force_update = 0;
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        int app_version_code = int.parse(packageInfo.buildNumber);
        print("app_version_code>> "+app_version_code.toString());
        if (app_version_code == version_code) {
          force_update = 0;
        } else if (force_update == 1) {
          _onAlertWithStylePressed2(
            context,
          );
        } else if (app_version_code < version_code) {
          _onAlertWithStylePressed2(
            context,
          );
        }
      }else{
        appUpdateMsg = user.updatemsg;
        headerMsg="";
//    _onAlertWithStylePressed2(
//      context,
//    );
      }
    }


  }

  _onAlertWithStylePressed2(context) {
    String paymentMode = "CASH";
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            content: StatefulBuilder(
              // You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: isShowAppUpdate==2? 200:150,
                    width: SizeConfig.safeBlockHorizontal * 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: new Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              new Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          headerMsg!="" ?  SizedBox(
                                            width:
                                            SizeConfig.safeBlockHorizontal *
                                                70,
                                            child: new Text(
                                              headerMsg,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                letterSpacing: 1,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(10.0, 10.0),
                                                    blurRadius: 3.0,
                                                    color: Colors.transparent,
                                                  ),
                                                  Shadow(
                                                    offset: Offset(10.0, 10.0),
                                                    blurRadius: 8.0,
                                                    color: Colors.transparent,
                                                  ),
                                                ],
                                                fontWeight: FontWeight.w600,

                                              ),
                                            ),
                                          ):new Container(),
                                          headerMsg!="" ? SizedBox(
                                            height: 20,
                                          ):new Container(),
                                          SizedBox(
                                            width: SizeConfig
                                                .safeBlockHorizontal *
                                                70,
                                            child: new Text(
                                              appUpdateMsg,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: 1,
                                                fontSize: 15,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(
                                                        10.0, 10.0),
                                                    blurRadius: 3.0,
                                                    color: Colors
                                                        .transparent,
                                                  ),
                                                  Shadow(
                                                    offset: Offset(
                                                        10.0, 10.0),
                                                    blurRadius: 8.0,
                                                    color: Colors
                                                        .transparent,
                                                  ),
                                                ],
                                                fontWeight:
                                                FontWeight.w500,


                                              ),
                                            ),
                                          )

                                        ],
                                      )
                                    ],
                                  )),

                            ],
                          ),
                        ),
                        new Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child:
                            new Container(
                              padding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 1, right: 1),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                              ),
                              width: SizeConfig.safeBlockHorizontal * 90,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    width:
                                    SizeConfig.safeBlockHorizontal * 30,
                                    margin: EdgeInsets.only(
                                        left: 0,
                                        right: 10,
                                        bottom: 0,
                                        top: 0),
                                    child: new MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        if (force_update == 1) {
                                          exit(0);
                                        }
                                      },
                                      colorBrightness: Brightness.light,
                                      splashColor: Colors.white,
                                      color: Colors.red,
                                      textColor: Colors.white,
                                      elevation: 5,
                                      padding: const EdgeInsets.all(10.0),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      child: new Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Text( isShowAppUpdate==2? "OK":"Cancel".toUpperCase(),
                                              style: TextStyle(


                                                fontSize: 15,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  isShowAppUpdate==1?   new Container(
                                    width:
                                    SizeConfig.safeBlockHorizontal * 30,
                                    margin: EdgeInsets.only(
                                        left: 10, right: 0, bottom: 0),
                                    child: new MaterialButton(
                                      onPressed: () {

                                        LaunchReview.launch(
                                            androidAppId: "com.pinkshastra.care4parents_app", iOSAppId: "1546813274");

                                      },
                                      colorBrightness: Brightness.light,
                                      splashColor: Colors.white,
                                      color: Colors.green,
                                      textColor: Colors.white,
                                      elevation: 5,
                                      padding: const EdgeInsets.all(10.0),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      child: new Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Text("Update".toUpperCase(),
                                              style: TextStyle(

                                                fontSize: 15,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ):new Container(),
                                ],
                              ),
                            )

                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  void asyncSharePref() async {
    if (widget.banners == null) {
      banners = await SharedPreferenceHelper.getBannersPref();
      if (banners != null && banners.whychoose.length > 0) {
        print('didChangeDependencies called');
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        height: heightOfScreen,
        width: widthOfScreen,
        margin: EdgeInsets.only(top: 0),
        child: new Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                 
                  SpaceH24(),
                  SpaceH4(),
                  Logo(widthOfScreen: widthOfScreen),
                  SpaceH8(),
                  UserTypeCarousel(
                      banners:
                          widget.banners == null ? banners : widget.banners),
                  SpaceH8(),
                  UserTypeButton(),
                  SpaceH8(),
                ],
              ),
            ),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: _buildFab(context),
    );
    // );
  }
}

Widget _buildFab(BuildContext context) {

  return Container(
    margin: EdgeInsets.only(top: 10, right: 0),
    height: 50.0,
    width: 50.0,
    child: FittedBox(
      child: FloatingActionButton(

        backgroundColor: AppColors.white,
        onPressed: () async {
          var whatsappUrl ="https://api.whatsapp.com/send?phone=918076483073";
          await  launch(whatsappUrl);
          // Enter thr package name of the App you want to open and for iOS add the URLscheme to the Info.plist file.
          // The second arguments decide wether the app redirects PlayStore or AppStore.
          // For testing purpose you can enter com.instagram.android
        },
        tooltip: 'Record Vitals',
        child: Image.asset(
          ImagePath.WHATSAPP_ICON,
        ),
        elevation: 10,
      ),
    ),
  );
}

class UserTypeButton extends StatelessWidget {

  const UserTypeButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
        margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_48),
        child: Column(
          children: [
            SpaceH8(),
            PrimaryButton(
              onPressed: () {

                onPressUser();
              },
              title: CommonButtons.CONTINUE,
              theme: theme,
              backgroundColor: AppColors.level,
            ),
            SpaceH8(),
          ],
        ));
  }

  void onPressRecordVital() {
    ExtendedNavigator.root.push(Routes.memberMobileScreen);
  }

  void onPressUser() {

    ExtendedNavigator.root.push(Routes.welcomeScreen);
  }
}

class UserTypeCarousel extends StatelessWidget {
  const UserTypeCarousel({Key key, this.banners}) : super(key: key);

  final Banners banners;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return
        // BlocBuilder<OtherCubit, OtherState>(builder: (context, state) {
        //   if (state is OtherInitial) {
        //     return Container(
        //       height: 200.0,
        //     );
        //   } else if (state is Loading) {
        //     return Container(
        //       height: 200.0,
        //     );
        //   } else if (state is LoadedBanner) {
        Column(
      children: [
        // Text(
        //   StringConst.USERTYPE_TITLE,
        //   style: theme.textTheme.headline5.copyWith(
        //     color: AppColors.black,
        //   ),
        //   textAlign: TextAlign.center,
        // ),
        // SpaceH12(),
        if (banners != null && banners.banners.length > 0)
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1.0,
              height:  SizeConfig.safeBlockVertical * 28,
              autoPlay: banners.banners.length == 1 ? false : true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: banners.banners.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: CachedNetworkImage(
                          imageUrl: image,
                          placeholder: (context, url) => Container()),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        if (banners != null && banners.whychoose.length > 0)
          CarouselSlider(
            options: CarouselOptions(
              height: SizeConfig.safeBlockVertical * 40,
              viewportFraction: 1.0,
              autoPlay: banners.whychoose.length == 1 ? false : true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: banners.whychoose.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: CachedNetworkImage(
                          imageUrl: image,
                          placeholder: (context, url) => AppLoading()),
                    ),
                    //   fit: BoxFit.cover,
                    // ),
                    // borderRadius:
                    //     new BorderRadius.all(new Radius.circular(4.0)),
                    // ),
                    // ),
                  );
                },
              );
            }).toList(),
          )
      ],
    );
  }
}
