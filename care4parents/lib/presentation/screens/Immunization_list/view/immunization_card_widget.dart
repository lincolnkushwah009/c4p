import 'package:care4parents/presentation/widgets/round_seconday_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ImmunizationCardWidget extends StatelessWidget {

  final String name,route,intake,startDate,remarks,endDate,prescription_file;
  final Function openlink;

  const ImmunizationCardWidget({
    Key key,

    @required this.name,this.route,this.intake,this.startDate,this.remarks,this.endDate,this.openlink,this.prescription_file

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(top: Sizes.MARGIN_12),
      child: Material(
        elevation: Sizes.ELEVATION_10,
        borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(
            //   RouteList.appointmentDetail,
            //   arguments: AppointmentDetailArguments(activityId),
            // );
          },
          child: Container(
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text:startDate!=null?  DateFormat.yMMMd()
                        .format(DateTime.parse(startDate)):"",
                    style: theme.textTheme.subtitle1.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w200,
                    ),

                  ),
                ),
                prescription_file!=null&&prescription_file!=""? GestureDetector(child: Row(
                  children: [
                    Text(
                      StringConst.Prescription,
                      style: theme.textTheme.caption.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 12,
                      color: AppColors.primaryColor,
                    )
                  ],
                ),
                  onTap: this.openlink,):new Container()
              ],
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(
                  name!=null? name:"",
                  style: theme.textTheme.headline6.copyWith(
                      color: AppColors.black, fontWeight: FontWeight.w700),
                ),
              ),

            ],
          ),


            route!=null&&route != ''
                ? LabelValue(
              label: StringConst.label.ROUTE,
              value: route.toString(),
              theme: theme,
            ):new Container(),


            remarks!=null&&remarks != ''
                ? LabelValue(
              label: StringConst.label.REMARKS,
              value: remarks.toString(),
              theme: theme,
            ):new Container(),


        ],),
      ),
    ),
        ),
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
      padding: const EdgeInsets.only(top: Sizes.PADDING_8),
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
class LabelValuePay extends StatelessWidget {
  const LabelValuePay({
    Key key,
    @required this.label,this.link,
    @required this.value,
    @required this.theme,this.onclick
  }) : super(key: key);

  final String label;
  final String value;
  final String link;
  final ThemeData theme;
  final  Function onclick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.PADDING_8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyText1.copyWith(
                fontSize: Sizes.SIZE_16.sp,
              ),
            ),
          ),

          Expanded(
            child: new Row(children: [
              new MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),

                ),
                textColor: AppColors.primaryColor,
                splashColor: AppColors.primaryColor,
                elevation: 5,
                height: 35,

                color: AppColors.primaryColor,
                onPressed: this.onclick,child: Text(
                value,
                style: theme.textTheme.button.copyWith(
                  color: AppColors.white,
                ),
              ),)
            ],),
          )
        ],
      ),
    );
  }
}