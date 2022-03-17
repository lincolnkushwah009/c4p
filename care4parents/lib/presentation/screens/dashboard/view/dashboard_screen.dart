import 'dart:async';
import 'dart:io';

import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/data/models/vital_top_result.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/screens/welcome/Data.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/util/SizeConfig.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:auto_route/auto_route.dart';

import 'package:care4parents/data/models/vital_type_result.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/vitaltype_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/view/family_list.dart';
import 'package:care4parents/presentation/screens/dashboard/view/vital_chart.dart';
import 'package:care4parents/presentation/screens/dashboard/view/vital_table.dart';
import 'package:care4parents/presentation/screens/menu/bloc/drawer_bloc.dart';

import 'package:care4parents/presentation/screens/menu/view/menu_screen.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants.dart';
import 'dummy_dashboard.dart';


class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateFormat newFormat = DateFormat("yyyy-MM-dd");
  DateFormat parseFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  // String startDate;
  String adminNumber = '8076483073';
  bool _isFirst = true;
  String _mobile;
  String remotePDFpath;
  DrawerBloc _drawerBloc;
  DashboardBloc _dashboardBloc;
  VitaltypeBloc _vitaltypeBloc;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final HomePageController myController = HomePageController();
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  @override
  void initState() {
    super.initState();
    readLocal();
    _drawerBloc = DrawerBloc();
    _dashboardBloc = getItInstance<DashboardBloc>();
    _vitaltypeBloc = getItInstance<VitaltypeBloc>();
  }

  readLocal() async {
    print("xsdf>> sonu jjjj ");

    FirebaseDatabase.instance.ref().once().then((value) {
      print(' ppp  Connected to second database and read ${value.snapshot.value}');
//      var data = snapshot.value;
//      print("xsdf>> "+snapshot.value);

      if (value.snapshot.value != null) {
        var user = Data.fromfcmVersionJson(value.snapshot.value);
        parseappversionbyfcm(user);
      }
    }).catchError((error) {});
  }

  int force_update = 0, isShowAppUpdate = 1;
  String downloadingStr = "",
      headerMsg = "",
      appUpdateMsg = "Would you like to update?";
  parseappversionbyfcm(user) async {
    if (Platform.isIOS) {
      int version_code = user.iosversion;
      force_update = user.iosForceupdate;
      print("force_update>> " + force_update.toString());
      print("version_code>> " + version_code.toString());
      appUpdateMsg = user.message;
      headerMsg = user.headermsg;
      isShowAppUpdate = user.show_updateios;

      if (isShowAppUpdate == 1) {
        //force_update = 0;
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        int app_version_code = int.parse(packageInfo.buildNumber);
        print("app_version_code>> " + app_version_code.toString());
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
      } else {
        appUpdateMsg = user.updatemsg;
        headerMsg = "";
//    _onAlertWithStylePressed2(
//      context,
//    );
      }
    } else {
      int version_code = user.version_code;
      force_update = user.force_update;
      print("force_update>> " + force_update.toString());
      print("version_code>> " + version_code.toString());
      appUpdateMsg = user.message;
      headerMsg = user.headermsg;
      isShowAppUpdate = user.isShowAppUpdate;

      if (isShowAppUpdate == 1) {
        //force_update = 0;
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        int app_version_code = int.parse(packageInfo.buildNumber);
        print("app_version_code>> " + app_version_code.toString());
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
      } else {
        appUpdateMsg = user.updatemsg;
        headerMsg = "";
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
                    height: isShowAppUpdate == 2 ? 200 : 150,
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
                                          headerMsg != ""
                                              ? SizedBox(
                                                  width: SizeConfig
                                                          .safeBlockHorizontal *
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
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                )
                                              : new Container(),
                                          headerMsg != ""
                                              ? SizedBox(
                                                  height: 20,
                                                )
                                              : new Container(),
                                          SizedBox(
                                            width:
                                                SizeConfig.safeBlockHorizontal *
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
                                                fontWeight: FontWeight.w500,
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
                            child: new Container(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    width: SizeConfig.safeBlockHorizontal * 30,
                                    margin: EdgeInsets.only(
                                        left: 0, right: 10, bottom: 0, top: 0),
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
                                          new Text(
                                              isShowAppUpdate == 2
                                                  ? "OK"
                                                  : "Cancel".toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 15,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  isShowAppUpdate == 1
                                      ? new Container(
                                          width:
                                              SizeConfig.safeBlockHorizontal *
                                                  30,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 0, bottom: 0),
                                          child: new MaterialButton(
                                            onPressed: () {
                                              LaunchReview.launch(
                                                  androidAppId:
                                                      "com.pinkshastra.care4parents_app",
                                                  iOSAppId: "1546813274");
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
                                        )
                                      : new Container(),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  dateTimeRangePicker(index) async {
    DateTimeRange picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 20),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: DateTimeRange(
          end: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 13),
          start: DateTime.now(),
        ),
        builder: (context, child) {
          return Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 400.0,
                ),
                child: child,
              )
            ],
          );
        });

    print(picked);
    print('picked mobile' + _mobile);

    if (picked != null) {
      _vitaltypeBloc
          .add(ChnageDateListType(index, picked.start, picked.end, _mobile));
    } else {
      _vitaltypeBloc.add(ChnageDateListType(index, null, null, _mobile));
    }
  }

  demo(List<VitalTopResult> p, path, loaded, isDummy) async {
    File file = await createFileOfPdfUrl(path);
    if (file != null) {
      remotePDFpath = file.path;
      print('remotePDFpath' + remotePDFpath);
      print('remotePDFpath isDummy' + isDummy.toString());
      print('^^^^^^^^^8');

      await _vitaltypeBloc.add(ChangeListType(
          isDummy: isDummy,
          listType: p,
          ecgFile: path,
          ecgFile1: remotePDFpath,
          loaded: !loaded));
    }
  }

  File file;
  Future<File> createFileOfPdfUrl(path) async {
    // Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final url = path;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir;
      if (Platform.isAndroid) {
        dir = await getExternalStorageDirectory();
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      print("Download files");
      print("${dir.path}/$filename");
      file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    // return completer.future;
  }

  Future<void> callnow(url) async {
    String callurl = "tel:" + url;
    // if (await canLaunch(callurl)) {
      await launch(callurl);

  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    ThemeData theme = Theme.of(context);
    SizeConfig().init(context);
    return MultiBlocProvider(
        providers: [
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
          BlocProvider(
            create: (context) => _vitaltypeBloc,
          ),
        ],
        child: BlocListener<DashboardBloc, DashboardState>(
          listener: (context, state) async {
            if (state is LoadedFamilyList) {
              print('called######');
              if (state.userList.length > 0 && _isFirst) {
                print('called######1');
                setState(() {
                  _isFirst = false;
                });
                FamilyMainResult member =
                    await SharedPreferenceHelper.getSelectedFamilyPref();
                if (member != null) {
                  print('familyM is loaded');
                  await context
                      .read<VitaltypeBloc>()
                      .add(GetListTypes(member.family_member.phone));

                  _mobile = member.family_member.phone;
                } else {
                  await context
                      .read<VitaltypeBloc>()
                      .add(GetListTypes(state.userList[0].family_member.phone));

                  _mobile = state.userList[0].family_member.phone;
                }
              }
            }
            if (state is FamilyLoadError) {
              print('*****************FamilyLoadError*****************');
              print('^^^^^^^^^9');

              await _vitaltypeBloc.add(ChangeListType(isDummy: true));
            }
          },
          child: BlocBuilder<DrawerBloc, DrawerState>(
            builder: (BuildContext context, DrawerState state) => Scaffold(
              key: scaffoldKey,
              drawer: MenuScreen(),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
                child: CustomAppBar(
                  title: StringConst.DASHBOARD,
                  onLeadingTap: () => _openDrawer(),
                  trailing: [
                    IconButton(
                        icon: new Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                            size: Sizes.ICON_SIZE_30,
                          ),
                        ),
                        onPressed: () {
                          callnow(adminNumber);
                        }),
                    SpaceW8(),
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
                                      state.userList[index].family_member.id));
                              setState(() {
                                _mobile =
                                    state.userList[index].family_member.phone;
                              });
                              print("sonu index " + index.toString());

                              print("sonu mobile " +
                                  state.userList[index].family_member.phone
                                      .toString());

                              print("sonu _mobile " + _mobile);

                              await context.read<VitaltypeBloc>().add(
                                  GetListTypes(state
                                      .userList[index].family_member.phone));

                              // ;login
                              // goToMemberProfile(state.userList[index]);
                            },
                          ));
                        }
                        // else if (state is UpdateSelectedFamily &&
                        //     state.userList != null &&
                        //     state.userList.length > 0) {
                        //   return Container(
                        //       child: FamilyMemberList(
                        //     controller: myController,
                        //     userFamily: state.userList,
                        //     selectedId: state.selectedId,
                        //     onChange: (index) {
                        //       context.read<DashboardBloc>().add(
                        //           UpdateSelectedFamilyMemberId(
                        //               state.userList[index],
                        //               state.userList[index].family_member.id));

                        //       context.read<VitaltypeBloc>().add(GetListTypes(
                        //           state.userList[index].family_member.phone));
                        //       _mobile =
                        //           state.userList[index].family_member.phone;
                        //     },
                        //   ));
                        // }
                        {
                          return Container();
                        }
                      },
                    ),
                    new whatappIconwidget(isHeader:true)
                  ],
                ),
              ),
              body: GestureDetector(
                onTap: () {
                  myController.methodA();
                },
                child: SingleChildScrollView(
                  child: Center(
                    child: BlocListener<VitaltypeBloc, VitaltypeState>(
                      listener: (context, state) {
                        if (state is ChangedListType &&
                            state.ecgFile != null &&
                            !state.loaded) {
                          print('*****************demo******************');
                          demo(state.list, state.ecgFile, state.loaded,
                              state.isDummy);
                        }
                      },
                      child: BlocBuilder<VitaltypeBloc, VitaltypeState>(
                        builder: (context, state) {
                          if (state is Loading) {
                            print('Loading state ====================');
                            return new Container(
                              height: heightOfScreen,
                              child: AppLoading(),
                            );
                          } else if (state is ChangedListType) {
                            // print('ChangedListType ======================'+ state.ecgFile);
                            print('ChangedListType ======================' +
                                state.ecgFile1.toString());
                            print('ChangedListType ======================' +
                                state.isDummy.toString());
                            final String type = state.ecgFile;
                            if (state.isDummy) {
                              return Column(
                                children: [
                                  buildTopCareMemberCard(
                                      widthOfScreen: widthOfScreen),
                                  DummyDashbord(),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  buildTopCareMemberCard(
                                      widthOfScreen: widthOfScreen),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: state.list.length,
                                    itemBuilder: (context, index) {
                                      final List<VitalTypeResult> types =
                                          state.list[index].list;
                                      final String name =
                                          state.list[index].name;
                                      bool showGraph =
                                          state.list[index].showGraph;
                                      DateTime startDate =
                                          state.list[index].startDate;
                                      DateTime endDate =
                                          state.list[index].endDate;

                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          //
                                          SpaceH8(),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                  (types.length > 0)
                                                      ? Constants.switchName(
                                                          types[0].type)
                                                      : name,
                                                  style: theme
                                                      .textTheme.headline6),
                                            ),
                                          ),
                                          (types.length > 0
                                                  ? types[0].type != 'ecg'
                                                  : name != 'ECG')
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal:
                                                          Sizes.PADDING_16),
                                                  child: Row(
                                                    children: [
                                                      buildExpandedDate(
                                                          index,
                                                          startDate != null
                                                              ? newFormat
                                                                  .format(
                                                                      startDate)
                                                              : StringConst
                                                                  .label
                                                                  .Start_Date,
                                                          theme),
                                                      buildExpandedDate(
                                                          index,
                                                          endDate != null
                                                              ? newFormat
                                                                  .format(
                                                                      endDate)
                                                              : StringConst
                                                                  .label
                                                                  .End_Date,
                                                          theme),
                                                      buildRaisedButton(theme,
                                                          showGraph, index),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                          //: Container(),
                                          (types.length > 0)
                                              ? (types != null &&
                                                      types[0].value != null)
                                                  ? BgCard(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: Sizes
                                                                  .PADDING_16),
                                                      width:
                                                          widthOfScreen * 0.9,
                                                      height: showGraph
                                                          ? heightOfScreen * 0.5
                                                          : 40.0 * types.length,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        const Radius.circular(
                                                            Sizes.RADIUS_24),
                                                      ),
                                                      child: (showGraph)
                                                          ? types[0].type ==
                                                                  'sugar'
                                                              ? VitalSugarChart(
                                                                  vitalTypes:
                                                                      types)
                                                              : VitalChart(
                                                                  vitalTypes: types
                                                                      .take(4)
                                                                      .toList())
                                                          : VitalTable(
                                                              vitalTypes: types,
                                                              headers: Constants
                                                                  .generateHeader(
                                                                      types[0]),
                                                            ),
                                                    )
                                                  : BgCard(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: Sizes
                                                                  .PADDING_8),
                                                      width:
                                                          widthOfScreen * 0.9,
                                                      height: heightOfScreen *
                                                              0.4 +
                                                          100.0 * types.length,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        const Radius.circular(
                                                            Sizes.RADIUS_10),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            color: Colors.white,
                                                            height:
                                                                heightOfScreen *
                                                                    0.4,
                                                            child: (state.ecgFile1 !=
                                                                        null &&
                                                                    state.ecgFile1
                                                                            .toLowerCase()
                                                                            .indexOf(".pdf") >
                                                                        -1)
                                                                ? PDFView(
                                                                    filePath: state
                                                                        .ecgFile1,
                                                                    enableSwipe:
                                                                        true,
                                                                    swipeHorizontal:
                                                                        true,
                                                                    autoSpacing:
                                                                        true,
                                                                    pageFling:
                                                                        true,
                                                                    fitEachPage:
                                                                        true,
                                                                    fitPolicy:
                                                                        FitPolicy
                                                                            .HEIGHT,
                                                                    onRender:
                                                                        (_pages) {
                                                                      // setState(() {
                                                                      //   pages = _pages;
                                                                      //   isReady = true;
                                                                      // });
                                                                    },
                                                                    onError:
                                                                        (error) {
                                                                      print('error error error error errorerrorerrorerror' +
                                                                          error
                                                                              .toString());
                                                                    },
                                                                    onPageError:
                                                                        (page,
                                                                            error) {
                                                                      print(
                                                                          'page error: ${error.toString()}');
                                                                    },
                                                                    onPageChanged:
                                                                        (int page,
                                                                            int total) {
                                                                      print(
                                                                          'page change: $page/$total');
                                                                    },
                                                                  )
                                                                : AppLoading(),
                                                          ),
                                                          VitalTable(
                                                            vitalTypes: types,
                                                            headers: Constants
                                                                .generateHeader(
                                                                    types[0]),
                                                          ),
                                                          SpaceH4()
                                                        ],
                                                      ),
                                                    )
                                              : buildNotFoundCard(
                                                  widthOfScreen,
                                                  heightOfScreen,
                                                  types,
                                                  theme,
                                                  index)
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              );
                            }
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  BgCard buildNotFoundCard(double widthOfScreen, double heightOfScreen,
      List<VitalTypeResult> types, ThemeData theme, int index) {
    return BgCard(
      padding: EdgeInsets.symmetric(vertical: Sizes.PADDING_16),
      width: widthOfScreen * 0.9,
      height: heightOfScreen * 0.5,
      borderRadius: const BorderRadius.all(
        const Radius.circular(Sizes.RADIUS_24),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.PADDING_14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringConst.sentence.NOT_FOUND_P,
                textAlign: TextAlign.center,
                style: theme.textTheme.caption
                    .copyWith(color: AppColors.noDataText),
              ),
              SpaceH8(),
              InkWell(
                onTap: () {
                  _vitaltypeBloc
                      .add(ChnageDateListType(index, null, null, _mobile));
                },
                child: Icon(
                  Icons.refresh,
                  color: AppColors.primaryColor,
                  // size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildExpandedDate(int index, String date, ThemeData theme) {
    return new Expanded(
      // flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: OutlineButton(
          onPressed: () {
            dateTimeRangePicker(index);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: theme.textTheme.caption.copyWith(
                    color: AppColors.primaryColor, fontWeight: FontWeight.w600),
              ),
              SvgPicture.asset(
                ImagePath.DATE_ICON,
                height: 12,
                fit: BoxFit.fitHeight,
              )
            ],
          ),
        ),
      ),
    );
  }

  RaisedButton buildRaisedButton(ThemeData theme, bool showGraph, int index) {
    return RaisedButton(
      color: AppColors.primaryColor,
      hoverColor: AppColors.lightButton,
      onPressed: () {
        _vitaltypeBloc.add(CheckItemListType(index));
      },
      child: !showGraph
          ? Row(
              children: [
                Text(
                  'Graph',
                  style: theme.textTheme.caption.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.w600),
                ),
                SpaceW4(),
                Icon(
                  Icons.show_chart,
                  color: AppColors.white,
                  size: 12,
                )
              ],
            )
          : Row(
              children: [
                Text(
                  'List',
                  style: theme.textTheme.caption.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.w600),
                ),
                Icon(
                  Icons.list,
                  color: AppColors.white,
                )
              ],
            ),
    );
  }

  void _openDrawer() {
    scaffoldKey.currentState.openDrawer();
    myController.methodA();
  }

  void goToMemberProfile(member) {
    ExtendedNavigator.root
        .push(
          Routes.memberProfileScreen,
          arguments: MemberProfileScreenArguments(member: member),
        )
        .then(onGoBack);
  }

  Future<bool> onGoBack(dynamic value) async {
    refreshData();
    return true;
  }

  // .then(onGoBack);
  void refreshData() {
    _dashboardBloc.add(GetFamilyList());
  }
}

class buildTopCareMemberCard extends StatelessWidget {
  const buildTopCareMemberCard({
    Key key,
    @required this.widthOfScreen,
  }) : super(key: key);

  final double widthOfScreen;
  void goToMemberProfile(member) {
    if(member!=null){
      ExtendedNavigator.root.push(
        Routes.memberProfileScreen,
        arguments: MemberProfileScreenArguments(member: member),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(top: Sizes.PADDING_8, left: 0.0, right: 0.0),
      child: FutureBuilder(
          future: SharedPreferenceHelper.getSelectedFamilyPref(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              FamilyMainResult familyMainResult = snapshot.data;

              return InkWell(
                onTap: () {
                  goToMemberProfile(familyMainResult);
                },
                child: BgCard(
                  backgroundColor: AppColors.dashboardTopBack,
                  padding: EdgeInsets.symmetric(vertical: Sizes.PADDING_4),
                  width: widthOfScreen * 1,
                  height: familyMainResult.family_member.name.length > 40
                      ? 80.0
                      : 56.0,
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                  padding: const EdgeInsets.only(top:5.0),
                  child:Text(
                          familyMainResult.family_member.name.capitalize(),
                          maxLines: 2,
                          // familyMainResult.family_member.name + "",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.subtitle1.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700),
                        ),)
                      ),
                      FutureBuilder(
                          future: SharedPreferenceHelper.getUserPref(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              User user = snapshot.data;
                              return Container(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    familyMainResult.family_member.credits==null|| familyMainResult.family_member.credits==""?'CareCash - ₹0': 'CareCash - ₹' + familyMainResult.family_member.credits.toString() ,
                                    style: theme.textTheme.caption.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
