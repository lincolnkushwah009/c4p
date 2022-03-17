import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:care4parents/values/values.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

import 'button.dart';

class whatappIconwidget extends StatelessWidget {

  final bool isHeader;
  const whatappIconwidget({
    Key key,
this.isHeader
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0, right: isHeader?10:0),
      height: isHeader?35:50.0,
      width: isHeader?35:50.0,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: null,
          backgroundColor: AppColors.white,
          onPressed: () async {
//for android

            var whatsappUrl ="https://api.whatsapp.com/send?phone=918076483073";
            await  launch(whatsappUrl);

            // await LaunchApp.openApp(
            //     androidPackageName: 'com.whatsapp',
            //
            // );

            //for ios
            // await LaunchApp.openApp(
            //     androidPackageName: 'com.whatsapp',
            //     //iosUrlScheme: 'WhatApp Messenger',
            //
            //     iosUrlScheme: 'whatsapp://',
            //     // appStoreLink:
            //     // 'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
            //     appStoreLink: 'https://apps.apple.com/in/app/whatsapp-messenger/id310633997',
            //     openStore: false
            // );
            // Enter thr package name of the App you want to open and for iOS add the URLscheme to the Info.plist file.
            // The second arguments decide wether the app redirects PlayStore or AppStore.
            // For testing purpose you can enter com.instagram.android
          },
          tooltip: 'Record Vitals',
          child:isHeader? new Row(crossAxisAlignment: CrossAxisAlignment.center,children: [ Image.asset(
            ImagePath.WHATSAPP_ICON,
          )
          ],):Image.asset(
            ImagePath.WHATSAPP_ICON,
          ),
          elevation: 10,
        ),
      ),
    );
  }
}
