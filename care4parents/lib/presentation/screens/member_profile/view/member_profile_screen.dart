import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

const kSpacingUnit = 10;

class MemberProfileScreen extends StatelessWidget {
  final FamilyMainResult member;
  String carecashAmt;
  MemberProfileScreen({this.member,this.carecashAmt});


  String getTotal()  {

    if(carecashAmt!=null&&carecashAmt!=""){
      return (double.parse(member.family_member?.credits)+double.parse(carecashAmt)).toStringAsFixed(2);

    }
    return member.family_member?.credits;

  }
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    print("member>package>  "+member.packageData.toString());
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
          child: CustomAppBar(
            title: StringConst.MEMBER_PROFILE,
            leading: InkWell(
              onTap: () => ExtendedNavigator.root.pop(),
              child: Icon(Icons.arrow_back_ios),
            ),
            trailing: [

              new whatappIconwidget(isHeader:true)
            ],
            hasTrailing: true,
          ),
        ),
        body: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(children: [
                new BgCard(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: widthOfScreen,
                  height: heightOfScreen * 0.18,
                  gradient: switchGradientWithCode( member.packageData != null&& member.packageData.length>0
                      ? member.packageData[0].code
                      : "BASIC_FREE"),
                  child: Stack(children: [
                    new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: SvgPicture.asset(
                                    switchImageWithCode( member.packageData != null&& member.packageData.length>0
                                        ? member.packageData[0].code
                                        : "BASIC_FREE"),
                                  ),
                                ),
                              ]),
                        ]),
                  ]),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: heightOfScreen * 0.18, right: Sizes.MARGIN_20),
                    child: switchNameWithCode(
                        context,
                        member.packageData != null&& member.packageData.length>0
                            ? member.packageData[0].code
                            : "BASIC_FREE",member.packageData != null&& member.packageData.length>0
                        ? member.packageData[0].name
                        : "Base"),
                  ),
                ),
                MemberProfile(heightOfScreen: heightOfScreen, member: member),
              ]),
              TopLabelValue(
                label: member.family_member.name,
                value: member.family_member.relation,
                theme: theme,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (member.family_member.dob != null)
                    Expanded(
                      child: LabelValue(
                        label: StringConst.label.AGE,
                        value: getMemberAge(member.family_member.dob),
                        theme: theme,
                      ),
                    ),
                  Expanded(
                      child: LabelValue(
                    label: StringConst.label.GENDER,
                    value: member.family_member.gender,
                    theme: theme,
                  ))
                ],
              ),
              SpaceH12(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (member.family_member.dob != null)
                    Expanded(
                      child: LabelValue(
                        label: StringConst.label.MOBILE_NUMBER,
                        value: member.family_member.phone,
                        theme: theme,
                      ),
                    ),
                  Expanded(
                    child: LabelValue(
                      label: StringConst.label.EMAIL,
                      value: member.family_member.email,
                      theme: theme,
                    ),
                  ),
                ],
              ),
              SpaceH12(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (member.family_member.dob != null)
                    Expanded(
                      child: LabelValue(
                        label: StringConst.label.ADDRESS,
                        value: member.family_member.address,
                        theme: theme,
                      ),
                    ),

                  Expanded(
                    child: LabelValue(
                      label: StringConst.label.CareCash,
                      value: member.family_member.credits==null?"₹0":"₹"+getTotal(),
                      theme: theme,
                    ),
                  ),
                ],
              ),
              SpaceH12(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (member.family_member.dob != null)
                    Expanded(
                      child: LabelValue(
                        label: StringConst.label.EMERGENCY_CONTACT_PERSON,
                        value: member.family_member.emergency_contact_person,
                        theme: theme,
                      ),
                    ),
                ],
              ),
              SpaceH12(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (member.family_member.dob != null)
                    Expanded(
                      child: LabelValue(
                        label: StringConst.label.EMERGENCY_CONTACT_NO,
                        value: member.family_member.emergency_contact_no,
                        theme: theme,
                      ),
                    ),
                ],
              ),
              SpaceH12()
            ],
          ),
        ));
  }

  Gradient switchGradientWithCode(package) {
    Color colorBegain;
    Color colorEnd;
    switch (package) {
      case "BASIC_FREE":
        colorBegain = AppColors.white;
        colorEnd = AppColors.white;

        break;

      case "GOLD_QUARTER":
        colorBegain = AppColors.goldMembershipLight;
        colorEnd = AppColors.goldMembershipDark;
        break;

      case "QUARTERLY":
        colorBegain = AppColors.goldMembershipLight;
        colorEnd = AppColors.goldMembershipDark;
        break;
      case "HALF_YEARLY":
        colorBegain = AppColors.platinumMembershipLight;
        colorEnd = AppColors.platinumMembershipDark;
        break;
      case "ANNUAL":
        colorBegain = AppColors.platinumMembershipLight;
        colorEnd = AppColors.platinumMembershipDark;
        break;
      default:
        colorBegain = AppColors.white;
        colorEnd = AppColors.white;
    }
    return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          colorBegain,
          colorEnd,
        ]);
  }

  Text switchNameWithCode(context, package, name) {
    Color color;

    switch (package) {
      case "BASIC_FREE":
        color = AppColors.blackShade10;
       // name = 'Basic';
        break;

      case "GOLD_QUARTER":
        color = AppColors.goldMembershipDark;
       // name = 'Gold Quarter';
        break;

      case "QUARTERLY":
        color = AppColors.goldMembershipDark;
       // name = "Gold Annual";
        break;
      case "HALF_YEARLY":
        color = AppColors.platinumMembershipDark;
      //  name = "Platinum Non-Metro";
        break;
      case "ANNUAL":
        color = AppColors.platinumMembershipDark;
        //name = "Platinum Metro";
        break;
      default:
        color = AppColors.blackShade10;
    }
    return Text(name != null ? name.toUpperCase() : "",
        style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ));
  }

  String switchImageWithCode(package) {
    String imagePath;
    switch (package) {
      case "BASIC_FREE":
        imagePath = ImagePath.MEMBERSHIP_SILVER;

        break;

      case "GOLD_QUARTER":
        imagePath = ImagePath.MEMBERSHIP_GOLD;

        break;
      case "QUARTERLY":
        imagePath = ImagePath.MEMBERSHIP_GOLD;

        break;
      case "HALF_YEARLY":
        imagePath = ImagePath.MEMBERSHIP_PLATINUM;
        break;
      case "ANNUAL":
        imagePath = ImagePath.MEMBERSHIP_PLATINUM;
        break;

      default:
        imagePath = ImagePath.MEMBERSHIP_SILVER;
    }
    return imagePath;
  }

  String getMemberAge(String birthday) {
    if (birthday != '') {
      var birthDate = DateTime.tryParse(birthday);
      if (birthDate != null) {
        final now = new DateTime.now();

        int years = now.year - birthDate.year;
        int months = now.month - birthDate.month;
        int days = now.day - birthDate.day;

        if (months < 0 || (months == 0 && days < 0)) {
          years--;
          months += (days < 0 ? 11 : 12);
        }

        if (days < 0) {
          final monthAgo = new DateTime(now.year, now.month - 1, birthDate.day);
          days = now.difference(monthAgo).inDays + 1;
        }

        return '$years Yr $months Mo';
      } else {
        print('getTheKidsAge: not a valid date');
      }
    } else {
      print('getTheKidsAge: date is empty');
    }
    return '';
  }
}

class TopLabelValue extends StatelessWidget {
  const TopLabelValue({
    Key key,
    @required this.label,
    @required this.value,
    @required this.theme,
  }) : super(key: key);

  final String label;
  final String value;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            label.capitalize(),
            style: theme.textTheme.headline6.copyWith(
                color: AppColors.blackShade2, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style:
                theme.textTheme.caption.copyWith(color: AppColors.blackShade3),
          )
        ],
      ),
    );
  }
}

class LabelValue extends StatelessWidget {
  const LabelValue({
    Key key,
    @required this.label,
    @required this.value,
    @required this.theme,
  }) : super(key: key);

  final String label;
  final String value;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: Sizes.PADDING_10, left: Sizes.PADDING_24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.headline6.copyWith(
                color: AppColors.blackShade2,
                fontSize: Sizes.SIZE_16.sp,
                fontWeight: FontWeight.w400),
          ),
          Text(
            value,
            style:
                theme.textTheme.caption.copyWith(color: AppColors.blackShade3),
          )
        ],
      ),
    );
  }
}

class MemberProfile extends StatelessWidget {
  const MemberProfile({
    Key key,
    @required this.heightOfScreen,
    @required this.member,
  }) : super(key: key);

  final double heightOfScreen;
  final FamilyMainResult member;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin:
            EdgeInsets.only(top: heightOfScreen * 0.1, right: Sizes.MARGIN_12),
        child: CircularProfileAvatar(
          member.family_member.profile_pic != null &&
                  member.family_member.profile_pic != ""
              ? member.family_member.profile_pic
              : "", //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
          radius: 70, // sets radius, default 50.0
          backgroundColor:
              Colors.transparent, // sets background color, default Colors.white
          borderWidth: 1, // sets border, default 0.0
          initialsText: Text(
            member.family_member.name.characters.first,
            style: TextStyle(
                fontSize: 35, color: Colors.white, fontWeight: FontWeight.w500),
          ), // sets initials text, set your own style, default Text('')
          borderColor:
              AppColors.primaryColor, // sets border color, default Colors.white
          elevation:
              4.0, // sets elevation (shadow of the profile picture), default value is 0.0
          foregroundColor: AppColors.primaryColor.withOpacity(
              0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
          cacheImage: true, // allow widget to cache image against provided url
          // sets on tap
          showInitialTextAbovePicture:
              false, // setting it true will show initials text above profile picture, default false
        ),
      ),
    );
  }
}

class MemberAge {
  int years;
  int months;
  int days;
  MemberAge({this.years = 0, this.months = 0, this.days = 0});
}
