import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/widgets/divider_widget.dart';
import 'package:care4parents/presentation/widgets/logo_widget.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const double kPadding = Sizes.PADDING_14;

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        height: heightOfScreen,
        width: widthOfScreen,
        margin: EdgeInsets.only(top: heightOfScreen * 0.1),
        child: new SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Logo(widthOfScreen: widthOfScreen),
              SpaceH24(),
              WelcomeText(),
              SpaceH24(),
              WelcomeButton(),
              SpaceH8(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: new whatappIconwidget(isHeader:false),

    );
  }
}

Widget _buildFab(BuildContext context) {
  return Container(
    height: 600.0,
    width: 100.0,
    child: FittedBox(
      child: FloatingActionButton(
        heroTag: null,
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          ExtendedNavigator.root.push(Routes.recordVitalScreen);
        },
        tooltip: 'Record Vitals',
        child: SvgPicture.asset(ImagePath.RECORD_VITAL_ICON),
        elevation: Sizes.ELEVATION_10,
      ),
    ),
  );
}

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
        margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_48),
        child: new Container(
          child: Column(
            children: [
              PrimaryButton(
                onPressed: () {
                  onPressLogin();
                },
                title: CommonButtons.LOGIN,
                theme: theme,
              ),
              SpaceH12(),
              HorizontalDivider(),
              SpaceH12(),
              PrimaryButton(
                onPressed: () {
                  onPressSignup();
                },
                title: CommonButtons.SIGNUP,
                theme: theme,
              ),
              SpaceH12(),
              HorizontalDivider(),
              SpaceH12(),
              PrimaryButton(
                onPressed: () {
                  onPressRecordVital();
                },
                title: CommonButtons.RECORD_VITAL,
                theme: theme,
                backgroundColor: AppColors.level,
              ),



            ],
          ),
        ));
  }

  void onPressLogin() {
    ExtendedNavigator.root.push(Routes.loginScreen);
  }

  void onPressSignup() {
    ExtendedNavigator.root.push(Routes.signupScreen);
  }
}

void onPressRecordVital() {
  ExtendedNavigator.root.push(Routes.memberMobileScreen);
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Text(
          StringConst.WELCOME_TITLE,
          style: theme.textTheme.headline5.copyWith(
            color: AppColors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SpaceH12(),
        Text(
          StringConst.WELCOME_DESCRIPTION,
          style: theme.textTheme.subtitle1.copyWith(
            color: AppColors.blackShade3,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: DividerGrey()),
      ),
      Text(StringConst.WELCOME_OR),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: DividerGrey()),
      ),
    ]);
  }
}
