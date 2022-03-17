import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/routes/auth_guard.dart';
import 'package:care4parents/util/SizeConfig.dart';
import 'package:care4parents/util/screen_utill.dart';
import 'package:care4parents/values/values.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class Care4ParentsApp extends StatefulWidget {
  @override
  _Care4ParentsAppState createState() => _Care4ParentsAppState();
}

class _Care4ParentsAppState extends State<Care4ParentsApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConst.APP_NAME,
      theme: AppTheme.lightThemeData,
      builder: ExtendedNavigator<AppRouter>(
        router: AppRouter(),
        // initialRoute: Routes.splashScreen,
        guards: [AuthGuard()],
      ),
    );
  }
}
