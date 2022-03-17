import 'package:care4parents/presentation/widgets/round_seconday_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class SubscriptionCardWidget extends StatelessWidget {
  final String invoice_no;
  final String name;
  final String subscription_date;
  final String paymentLink;
  final String amount;
  final String status;
  final Function openLink,openInvoiceLink;

  const SubscriptionCardWidget({
    Key key,
    @required this.invoice_no,
    @required this.name,
    @required this.subscription_date,
    @required this.paymentLink,
    @required this.amount,
    this.openLink,this.status,this.openInvoiceLink
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
          child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.RADIUS_16),
              child: Padding(
                padding: const EdgeInsets.all(Sizes.PADDING_20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        invoice_no!=null?Text(
                          invoice_no,
                          style: theme.textTheme.subtitle1.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w200,
                          ),
                        ):new Container(),
                        GestureDetector(child: Row(
                          children: [
                            Text(
                              StringConst.VIEW_INVOICE,
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
                        onTap: this.openInvoiceLink,)
                      ],
                    ),
                    Text(
                      name!=null?name:"",
                      style: theme.textTheme.headline6.copyWith(
                          color: AppColors.black, fontWeight: FontWeight.w700),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        subscription_date != ''
                            ? LabelValue(
                                label: StringConst.label.SUBSCRIPTION_DATE,
                                value: DateFormat.yMMMd()
                                    .format(DateTime.parse(subscription_date)),
                                theme: theme,
                              )
                            : Container(),

                        amount != ''
                            ? LabelValue(
                                label: StringConst.label.PACKAGE_AMOUNT,
                                value: "₹"+amount,
                                theme: theme,
                              )
                            : Container(),
                        status!=null&&status != ''
                            ? LabelValue(
                          label: StringConst.label.STATUS,
                          value: status.toString(),
                          theme: theme,
                        )
                            : Container(),
                        status!=null&&status.toLowerCase() != "paid" && paymentLink != ''
                            ? LabelValuePay(
                          label: StringConst.label.PAYMENT_LINK,
                          link: paymentLink,

                          value:StringConst.label.PAY_NOW,
                          theme: theme,
                          onclick:this.openLink,
                        )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              )),
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
                  color: AppColors.grey
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
                height: 30,

                color: AppColors.primaryColor,
                onPressed: this.onclick,child: Text(
                value,
                style: theme.textTheme.button.copyWith(
                  color: AppColors.white,
                ),
              ),
              )
            ],),
          )
        ],
      ),
    );
  }
}