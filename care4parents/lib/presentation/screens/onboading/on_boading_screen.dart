import 'package:auto_route/auto_route.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/screens/other/cubit/other_cubit.dart';
import 'package:care4parents/presentation/widgets/logo_widget.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/values/values.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:care4parents/util/screen_utill.dart';

const double kPadding = Sizes.PADDING_14;

class OnBoardingItem {
  OnBoardingItem(this.imagePath, this.title, this.subtitle);

  final String imagePath;
  final String title;
  final String subtitle;
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController = PageController();
  double currentIndexPage;
  Banners banners;
  int pageLength;
  List<OnBoardingItem> onBoardingItemList = [
    OnBoardingItem(
      ImagePath.ONBOADING1,
      StringConst.ONBOARDING_TITLE_1,
      StringConst.ONBOARDING_DESC_1,
    ),
    OnBoardingItem(
      ImagePath.ONBOADING2,
      StringConst.ONBOARDING_TITLE_2,
      StringConst.ONBOARDING_DESC_2,
    ),
    OnBoardingItem(
      ImagePath.ONBOADING3,
      StringConst.ONBOARDING_TITLE_3,
      StringConst.ONBOARDING_DESC_3,
    ),
  ];

  @override
  void initState() {
    super.initState();
    currentIndexPage = 0;
    pageLength = onBoardingItemList.length;
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        height: heightOfScreen,
        width: widthOfScreen,
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: _buildOnBoardingItems(onBoardingItemList),
              onPageChanged: (value) {
                setState(() => currentIndexPage = value.toDouble());
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPadding, vertical: Sizes.PADDING_8),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _buildDotsIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildOnBoardingItems(List<OnBoardingItem> onBoardingItemList) {
    List<Widget> items = [];

    for (int index = 0; index < onBoardingItemList.length; index++) {
      items.add(
        onBoardingItem(
          imagePath: onBoardingItemList[index].imagePath,
          title: onBoardingItemList[index].title,
          subtitle: onBoardingItemList[index].subtitle,
        ),
      );
    }
    return items;
  }

  Widget onBoardingItem({
    @required String imagePath,
    @required String title,
    @required String subtitle,
  }) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    ThemeData theme = Theme.of(context);
    return Stack(
      children: [
        Center(
          child: Container(
            height: heightOfScreen * 0.8,
            padding: const EdgeInsets.all(kPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Logo(widthOfScreen: widthOfScreen),
                SpaceH48(),
                SvgPicture.asset(
                  imagePath,
                  height: (heightOfScreen * 0.3),
                  // height: heightOfScreen * 0.3,
                  fit: BoxFit.contain,
                ),
                SpaceH12(),
                Column(
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.headline5.copyWith(
                        color: AppColors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SpaceH12(),
                    Text(
                      subtitle,
                      style: theme.textTheme.subtitle2.copyWith(
                        color: AppColors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDotsIndicator() {
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildControls(),
        SpaceH12(),
        if (isLastItem())
          Container(
            margin: EdgeInsets.only(bottom: Sizes.MARGIN_10),
            child: Center(
              child: PrimaryButton(
                onPressed: () {
                  onPressed();
                },
                title: isLastItem() ? CommonButtons.FINISH : CommonButtons.NEXT,
                theme: theme,
              ),
            ),
          )
      ],
    );
  }

  bool isFirstItem() {
    return currentIndexPage > 0 && currentIndexPage < pageLength;
  }

  bool isLastItem() {
    return currentIndexPage == pageLength - 1;
  }

  Widget _buildControls() {
    return Container(
      height: assignHeight(context: context, fraction: 0.1),
      child: DotsIndicator(
        dotsCount: pageLength,
        position: currentIndexPage,
        decorator: DotsDecorator(
          color: AppColors.white,
          activeColor: AppColors.primaryColor,
          size: Size(Sizes.SIZE_16, Sizes.SIZE_16),
          activeSize: Size(Sizes.SIZE_24, Sizes.SIZE_16),
          shape: RoundedRectangleBorder(
              side: new BorderSide(color: AppColors.primaryColor),
              borderRadius:
                  new BorderRadius.all(new Radius.circular(Sizes.RADIUS_60))),
          activeShape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(const Radius.circular(Sizes.RADIUS_60)),
          ),
          spacing: EdgeInsets.symmetric(horizontal: Sizes.SIZE_4),
        ),
      ),
    );
  }

  void _slideBackwards() {
    if (currentIndexPage < (pageLength - 1) && currentIndexPage != 0) {
      setState(() {
        currentIndexPage -= 1.toDouble();
      });
      movePageViewer(currentIndexPage);
    }
  }

  void _slideForward() {
    if (currentIndexPage < pageLength - 1) {
      setState(() {
        currentIndexPage += 1.toDouble();
      });
      movePageViewer(currentIndexPage);
    }
  }

  void movePageViewer(double position) {
    _pageController.animateToPage(
      position.toInt(),
      duration: Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  Future<void> onPressed() async {
    if (isLastItem()) {
      await SharedPreferenceHelper.setIsFirstLoadPref(true);
      banners = await SharedPreferenceHelper.getBannersPref();
      // print('banners =====>' + banners.toString());
      // await Future.delayed(Duration(milliseconds: 3500), () {
      ExtendedNavigator.root.pushAndRemoveUntil(
          Routes.userTypeScreen, (route) => false,
          arguments: UserTypeScreenArguments(banners: banners));
      // });
      // ExtendedNavigator.root.push(Routes.userTypeScreen);
    } else {
      _slideForward();
    }
  }
}
