import 'package:flutter/material.dart';
import 'package:care4parents/values/values.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;

  const Button({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.secondaryColor,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.RADIUS_10),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: Sizes.PADDING_10),
      margin: EdgeInsets.symmetric(vertical: Sizes.MARGIN_10),
      height: Sizes.HEIGHT_100,
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          text.t(context),
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
