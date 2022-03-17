import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/screens/book_appointment/view/date.dart';
import 'package:care4parents/presentation/screens/book_appointment/view/time_slot.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/custom_snackbar.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalenderScreen extends StatefulWidget {
  CalenderScreen({Key key}) : super(key: key);

  @override
  _CalenderScreenState createState() => new _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  String date;
  String time;
  bool showError = false;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    setState(() {
      date = formatter.format(DateTime.now());
    });
  }

  void _setDate(String date1) {
    setState(() {
      date = date1;
    });
    print('date >>>>>>>>' + date);

  }

  void _setTime(String time1) {
    setState(() {
      time = time1;
    });
    print('time >>>>>>>>' + time);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
        child: CustomAppBar(
            title: StringConst.sentence.SELECT_DATE_TIME,
            leading: InkWell(
              onTap: () => ExtendedNavigator.root.pop(),
              child: Icon(Icons.arrow_back_ios),
            ),
            hasTrailing: false),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (showError)
              Text('Select date and time',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: AppColors.redShade5)),
            Container(
              // margin: EdgeInsets.all(16.0),
              color: AppColors.drawerBackColor,
              child: DatePage(setDate: _setDate),
            ),
            TimeSlot(setTime: _setTime,selectedDate:date),
            SpaceH44()
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TextButton(
          //     child: Text("Skip".toUpperCase(), style: TextStyle(fontSize: 14)),
          //     style: ButtonStyle(
          //         padding:
          //             MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
          //         foregroundColor:
          //             MaterialStateProperty.all<Color>(AppColors.primaryColor),
          //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //             RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(18.0),
          //                 side: BorderSide(color: AppColors.primaryColor)))),
          //     onPressed: () => null),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                print(date);
                print(time);
                if (date == null || time == null) {
                  print(date);
                  print(time);
                  setState(() {
                    showError = true;
                  });
                  // SnackBarWidgets.buildErrorSnackbar(
                  //     context, 'Select date and time');
                } else {
                  print(date);
                  print(time);
                //  ExtendedNavigator.root.pop('$date $time');
                }
              },
              color: AppColors.primaryColor,
              textColor: Colors.white,
              child: Text('Confirm'),
            ),
          ),
        ],
      ),
    );
  }
}
