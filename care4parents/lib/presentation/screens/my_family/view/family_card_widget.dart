import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';

class FamilyCardWidget extends StatelessWidget {
  final int id;
  final String name,credits;
  final String relation;
  final String gender;
  final String phone;
 final FamilyMember family_member;

  const FamilyCardWidget({
    Key key,
    @required this.id,
    @required this.name,
    this.credits,
    @required this.relation,
    @required this.gender,
    @required this.phone,
    this.family_member
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(top: Sizes.MARGIN_12),
      child: Material(
        elevation: Sizes.ELEVATION_10,
        borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
        child:  ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.RADIUS_16),
              child: Padding(
                padding: const EdgeInsets.all(Sizes.PADDING_20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.headline5.copyWith(
                          color: AppColors.black, fontWeight: FontWeight.w800),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        LabelValue(
                          label: StringConst.label.RELATION,
                          value: relation != null ? relation : "",
                          theme: theme,
                        ),
                        LabelValue(
                          label: StringConst.label.GENDER,
                          value: gender != null ? gender : "",
                          theme: theme,
                        ),
                        LabelValue(
                          label: StringConst.label.PHONE_NUMBER,
                          value: phone != null ? phone : "",
                          theme: theme,
                        ),
                        LabelValue(
                          label: StringConst.label.CareCash,
                          value: credits != null ? "₹"+credits : "₹0",
                          theme: theme,
                        ),
                      ],
                    ),
                  ],
                ),
              )),

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
      padding: const EdgeInsets.only(top: Sizes.PADDING_10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyText1.copyWith(
                fontSize: Sizes.SIZE_16.sp,
                color: AppColors.grey
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}
