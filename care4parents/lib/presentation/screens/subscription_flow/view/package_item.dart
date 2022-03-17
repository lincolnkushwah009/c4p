import 'package:care4parents/domain/entities/package.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

final formatCurrency =
    new NumberFormat.currency(symbol: '₹ ', decimalDigits: 0);

class PackageItem extends StatelessWidget {
  final Package _item;
  final int selectedPackageId;
  PackageItem(this._item, this.selectedPackageId);

  @override
  Widget build(BuildContext context) {
    double height = assignHeight(context: context, fraction: 1.0);
    double width = assignWidth(context: context, fraction: 1.0);
    ThemeData theme = Theme.of(context);

    return (_item.status == true)
        ? new Container(
            margin: new EdgeInsets.symmetric(vertical: 10.0),
            child: new BgCard(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: width,
              height: height * 0.18,
              borderRadius: const BorderRadius.all(
                const Radius.circular(Sizes.RADIUS_10),
              ),
              borderColor:
                  ((_item.isSelected == true && selectedPackageId == '') ||
                          _item.id == selectedPackageId)
                      ? AppColors.black
                      : AppColors.white,
              borderWidth:
                  ((_item.isSelected == true && selectedPackageId == '') ||
                          _item.id == selectedPackageId)
                      ? 3.0
                      : 0,
              gradient: switchGradientWithType(_item.type),
              child: Stack(
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
                              _item.name,
                              style: theme.textTheme.subtitle1.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: textColorWithType(_item.type)),
                            ),
                            Text(
                              '${formatCurrency.format(_item.price)}',
                              style: theme.textTheme.subtitle1.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: textColorWithType(_item.type)),
                            ),
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: SvgPicture.asset(
                                switchImageWithType(_item.type),
                                height: Sizes.HEIGHT_80,
                                // color: trailingColor,
                              ),
                            ),
                          ]),
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    left: 80,
                    child: Row(
                      children: [
                        Text(
                          'View Package',
                          style: theme.textTheme.caption.copyWith(
                              fontWeight: FontWeight.w900,
                              color: textColorWithType(_item.type)),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,
                            size: 12,
                            color: _item.index == 1
                                ? AppColors.black
                                : AppColors.white)
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 20,
                    child: Text(
                      _item.duration,
                      style: theme.textTheme.caption.copyWith(
                          fontWeight: FontWeight.w900,
                          color: textColorWithType(_item.type)),
                    ),
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
