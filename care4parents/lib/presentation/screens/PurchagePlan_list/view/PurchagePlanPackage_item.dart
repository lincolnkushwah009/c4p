import 'package:care4parents/domain/entities/package.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/widgets/auth/bg_card_auto.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

final formatCurrency =
new NumberFormat.currency(symbol: '₹ ', decimalDigits: 0);

class PackageItemPlan extends StatelessWidget {
   Package item;
   int selectedPackageId;
   Function onViewPackageClick;
  PackageItemPlan({
    Key key,
    this.item, this.selectedPackageId,this.onViewPackageClick
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = assignHeight(context: context, fraction: 1.0);
    double width = assignWidth(context: context, fraction: 1.0);
    ThemeData theme = Theme.of(context);

    return (item.status == true)
        ? new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
      child: new BgCardAuto(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: width,
        borderRadius: const BorderRadius.all(
          const Radius.circular(Sizes.RADIUS_10),
        ),
        borderColor:
        ((item.isSelected == true && selectedPackageId == '') ||
            item.id == selectedPackageId)
            ? AppColors.white
            : AppColors.white,
        borderWidth:
        ((item.isSelected == true && selectedPackageId == '') ||
            item.id == selectedPackageId)
            ? 0.0
            : 0,
        gradient: switchGradientWithType(item.type),
        child: Stack(
          children: [
            new Column(
              children: [
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.name,
                            style: theme.textTheme.subtitle1.copyWith(
                                fontWeight: FontWeight.w900,
                                color: textColorWithType(item.type)),
                          ),
                          Text(
                            '${formatCurrency.format(item.price)}',
                            style: theme.textTheme.subtitle1.copyWith(
                                fontWeight: FontWeight.w700,
                                color: textColorWithType(item.type)),
                          ),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SvgPicture.asset(
                              switchImageWithType(item.type),
                              height: Sizes.HEIGHT_80,
                              // color: trailingColor,
                            ),
                          ),
                        ]),
                  ],
                ),

                SpaceH12(),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new GestureDetector(
                      onTap: (){
                        this.onViewPackageClick();
                      },
                      child:
                      Row(
                        children: [
                          Text(
                            'View Package',
                            style: theme.textTheme.caption.copyWith(
                                fontWeight: FontWeight.w900,
                                color: textColorWithType(item.type)),
                          ),
                          Icon(Icons.arrow_forward_ios_outlined,
                              size: 12,
                              color: item.index == 1
                                  ? AppColors.white
                                  : AppColors.white)
                        ],
                      ),),
                    Text(
                      item.duration,
                      style: theme.textTheme.caption.copyWith(
                          fontWeight: FontWeight.w900,
                          color: textColorWithType(item.type)),
                    )
                  ],
                ),
                SpaceH12(),
                item.isViewPackage!=null&&item.isViewPackage? new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[



                          new Row(

                            children: [
                              Text(
                                StringConst.label.description
                                ,
                                style: theme.textTheme.subtitle2.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: textColorWithType(item.type)),
                              ),
                              new Padding(padding: EdgeInsets.only(left: 10),child:
                              Text(
                                item.description,
                                style: theme.textTheme.caption.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: textColorWithType(item.type)),
                              ),)
                              ,
                            ],),

                        ]),
                  ],
                ):new Container(),
                item.isViewPackage!=null&&item.isViewPackage? SpaceH12():new Container(),
              ],
            ),

          ],
        ),
      ),
    )
        : new Container();
  }

  // element.type === 'SILVER'
  // ? 'silver-badge'
  //     : element.type === 'GOLD'
  // ? 'gold-badge'
  //     : element.type === 'PLATINUM'
  // ? 'platinum-badge'
  //     : 'silver-badge'
  Gradient switchGradientWithType(type) {
    Color colorBegain;
    Color colorEnd;

    if (type == 'GOLD') {
      colorBegain = AppColors.goldMembershipLight;
      colorEnd = AppColors.goldMembershipDark;
    } else if (type == 'PLATINUM') {
      colorBegain = AppColors.platinumMembershipLight;
      colorEnd = AppColors.platinumMembershipDark;
    } else {
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

  Color textColorWithType(type) {
    Color colorBegain;

    if (type == 'GOLD') {
      colorBegain = AppColors.white;
    } else if (type == 'PLATINUM') {
      colorBegain = AppColors.white;
    } else {
      colorBegain = AppColors.primaryColor;
    }

    return colorBegain;
  }

  String switchImageWithType(type) {
    String imagePath;

    if (type == 'GOLD') {
      imagePath = ImagePath.MEMBERSHIP_GOLD;
    } else if (type == 'PLATINUM') {
      imagePath = ImagePath.MEMBERSHIP_PLATINUM;
    } else {
      imagePath = ImagePath.MEMBERSHIP_SILVER;
    }

    return imagePath;
  }
}
