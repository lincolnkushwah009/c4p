import 'package:flutter/material.dart';
import 'package:care4parents/values/values.dart';
import 'package:care4parents/domain/entities/app_error.dart';

import 'button.dart';

class AppErrorWidget extends StatelessWidget {
  final AppErrorType errorType;
  final Function onPressed;

  const AppErrorWidget({
    Key key,
    @required this.errorType,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.PADDING_32),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              errorType == AppErrorType.api
                  ? StringConst.SWR
                  : StringConst.CHECKNETWORK,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          // ButtonBar(
          //   children: [
          //     Button(
          //       onPressed: onPressed,
          //       text: CommonButtons.RETRY,
          //     ),
          //     // Button(
          //     //   onPressed: () => {},
          //     //   text: CommonButtons.SAVE,
          //     // ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
