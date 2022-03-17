import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/dashboard/view/constants.dart';
import 'package:care4parents/presentation/screens/record_vital/model/record.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/round_seconday_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class RecordView extends StatefulWidget {
  final Record record;
  const RecordView({Key key, @required this.record}) : super(key: key);

  @override
  _RecordViewState createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  static const platform = const MethodChannel('com.agatsa.sanketlife/ecg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
        child: CustomAppBar(
            title: widget.record.title,
            // onLeadingTap: () => _openDrawer(),
            leading: InkWell(
                onTap: () => ExtendedNavigator.root.pop(),
                child: Icon(Icons.arrow_back_ios_outlined)),
            trailing: [

              new whatappIconwidget(isHeader:true)
            ],
            hasTrailing: true),
      ),
      body: Padding(
        padding: const EdgeInsets.all((Sizes.PADDING_10)),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PrimaryButton(
              onPressed: () async {
                  ExtendedNavigator.root.push(Routes.viewPastScreen,
                    arguments:
                        ViewPastScreenArguments(title:widget.record.title));
              },
              title: 'View Past',
              theme: Theme.of(context),
              backgroundColor: AppColors.lightButton,
            ),
            SpaceH12(),
            PrimaryButton(
              onPressed: () async {
                if(widget.record.screekKey == 'takeEcg'){
  ExtendedNavigator.root.push(Routes.ecgScreen,
                    arguments:
                        EcgScreenArguments(record: widget.record));
                }else{
  ExtendedNavigator.root.push(Routes.singleRecordVital,
                    arguments:
                        SingleRecordVitalArguments(record: widget.record));
                }
              
                // String _sdkResult = "";
                // try {
                //   _sdkResult =
                //       await platform.invokeMethod(widget.record.screekKey);
                // } catch (err) {
                //   print(widget.record.screekKey +
                //       " - sdk error ============= error: " +
                //       err.message);
                // }
                // print(_sdkResult);
              },
              title: 'Record New',
              theme: Theme.of(context),
            )
          ],
        ),
      ),
    );
  }
}
