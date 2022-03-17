import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';

class NewRecord extends StatelessWidget {
  const NewRecord({
    Key key,
    @required this.onTap,
    @required this.title,
  }) : super(key: key);

  final Function onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppColors.mainText,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SpaceW12(),
            Icon(
              Icons.add_circle_outline,
              size: Sizes.dimen_10.h,
              color: AppColors.mainText,
            ),
          ],
        ),
      ),
    );
  }
}
