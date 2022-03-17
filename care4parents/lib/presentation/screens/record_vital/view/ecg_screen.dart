import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/screens/record_vital/model/record.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EcgScreen extends StatefulWidget {
  final Record record;
  const EcgScreen({Key key, @required this.record}) : super(key: key);

  @override
  _EcgScreenState createState() => _EcgScreenState();
}

class Item {
  final String description;
  final String level;
  final String image;

  Item({
    this.image,
    @required this.level,
    this.description,
  });
}

class _EcgScreenState extends State<EcgScreen> {
  static const platform = const MethodChannel('com.agatsa.sanketlife/ecg');
  bool status = false;
  bool level2 = false;
  final List<Item> levels = [
    Item(
        image: ImagePath.ECG1_PNG,
        level: 'L1',
        description:
            'Place two thumbs on the front sensors. As shown in the image. \n\nKeep your hands in the same position for 15 seconds. \n\n'),
    Item(
        image: ImagePath.ECG2_PNG,
        level: 'L2',
        description:
            'Hold the device in your right hand. Place the right thumb on the right sensor and touch the side sensor on the lower side of left ankle. As shown in the image. \n\nKeep your hands in the same position fot 15 seconds. \n\nPlace the device in position & Click to take Lead 2.'),
    Item(level: 'V1'),
    Item(level: 'V2'),
    Item(level: 'V3'),
    Item(level: 'V4'),
    Item(level: 'V5'),
    Item(level: 'V6'),
//    Item(level: 'V7')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
        child: CustomAppBar(
            title: 'Standard 12 Lead ECG',
            // onLeadingTap: () => _openDrawer(),
            leading: InkWell(
                onTap: () => ExtendedNavigator.root.pop(),
                child: Icon(Icons.arrow_back_ios_outlined)),
            hasTrailing: false),
      ),
      body: ListView(children: [Padding(
        padding: const EdgeInsets.only(left:Sizes.PADDING_10,right:Sizes.PADDING_10,top: Sizes.PADDING_2,bottom: Sizes.PADDING_10
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50.0,
              child: (!status) ?
              ListView.builder(
                // shrinkWrap: true,
                itemBuilder: (context, index) {
                  final Item level = levels[index];
                  Color color =  AppColors.level ;
                  if(!level2 && level.level == 'L1'){
                    color = AppColors.levelOn;
                  } else if(level2 && level.level == 'L1'){
                    color = AppColors.levelDone;
                  }
                  if(level2 && level.level == 'L2'){
                    color = AppColors.levelOn;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                    child: Container(
                      width: 50.0,
                      alignment: Alignment.center,
                      color: color,
                      child: Container(
                        child: Text(
                          level.level,
                          style:  Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: levels?.length ,
                scrollDirection: Axis.horizontal,
              ) : Container(),
            ),
            !status ? Text(
              (!level2) ? levels[0].description : levels[1].description,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ) : Container(),
            SpaceH16(),
            Center(
              child: Image.asset(
                (!level2) ? levels[0].image : levels[1].image,
                // widget.record.imagePath,
                // color: AppColors.white,
              ),
            ),
            SpaceH16(),
            PrimaryButton(
              onPressed: () async {
                if (status) {
                  ExtendedNavigator.root.pop();
                } else {
                  String _sdkResult = "";
                  print('level2 ========================='+level2.toString());
                  try {
                    _sdkResult =
                    await platform.invokeMethod(level2 ? 'takeEcg2' :widget.record.screekKey);
                  } catch (err) {
                    print(widget.record.screekKey +
                        " - sdk error ============= error: " +
                        err.message);
                  }
                  print(_sdkResult);
                  Future.delayed(Duration(seconds: 2), () async {
                    if (widget.record.screekKey == "takeEcg" && !level2) {
                      print("takeEcg Secreen - L1");
                      setState(() {
                        level2 = true;
                      });
                    } else {
                      setState(() {
                        status = true;
                      });
                    }
                  });

                }
              },
              title: status ? CommonButtons.FINISH : CommonButtons.START,
              theme: Theme.of(context),
            )
          ],
        ),
      )],),
    );
  }
}
