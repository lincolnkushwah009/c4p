import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/screens/record_vital/model/record.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleRecordVital extends StatefulWidget {
  final Record record;
  const SingleRecordVital({Key key, @required this.record}) : super(key: key);

  @override
  _SingleRecordVitalState createState() => _SingleRecordVitalState();
}

class _SingleRecordVitalState extends State<SingleRecordVital> {
  static const platform = const MethodChannel('com.agatsa.sanketlife/ecg');
  bool status = false;

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
        child: new SingleChildScrollView(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.record.desc,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 17.0,
              ),
            ),
            widget.record.title=="Temperature"? SpaceH24():new Container(),
            Center(
              child: Image.asset(

                widget.record.imagePath,


                // color: AppColors.white,
              ),
            ),
            widget.record.title=="Temperature"? SpaceH24():new Container(),
            PrimaryButton(
              onPressed: () async {
                if (status) {
                  ExtendedNavigator.root.pop();
                } else {
                  String _sdkResult = "";
                  try {
                    _sdkResult =
                    await platform.invokeMethod(widget.record.screekKey);
                  } catch (err) {
                    print(widget.record.screekKey +
                        " - sdk error ============= error: " +
                        err.message);
                  }
                  print(_sdkResult);
                  Future.delayed(Duration(seconds: 2), () async {
                    if (widget.record.screekKey == "takeEcg") {
                      print("takeEcg Secreen - L2");
                      // await Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => EcgL2Page()));
                    } else {
                      setState(() {
                        status = true;
                      });
                      // await Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ResultPage(
                      //             result: Result(
                      //                 widget.todo.title,
                      //                 _sdkResult,
                      //                 widget.todo.imagePath,
                      //                 MyHomePage(title: "Home Page"),
                      //                 widget.todo.screekKey))));
                    }
                  });
                }
              },
              title: status ? CommonButtons.FINISH : CommonButtons.START,
              theme: Theme.of(context),
            )
          ],
        ),),
      ),
    );
  }
}
