import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/widgets/logo_widget.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/util/screen_utill.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
        left: Sizes.dimen_16.w,
        right: Sizes.dimen_16.w,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  ExtendedNavigator.root.pop(context);
                  // Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primaryColor,
                  size: 26.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: Sizes.MARGIN_10),
            child: Center(
              child: Logo(widthOfScreen: ScreenUtil.screenWidth),
            ),
          ),
        ],
      ),
    );
  }
}
