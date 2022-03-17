import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSlot extends StatefulWidget {
  final Function setTime;
  final  selectedDate;

  TimeSlot({Key key, this.setTime,this.selectedDate}) : super(key: key);

  @override
  _TimeSlotState createState() => _TimeSlotState(this.selectedDate);
}

class Time {
  Time({this.title, this.list});
  final String title;
  final List<IItem> list;

  Time.fromJson(Map<String, dynamic> json)
      : list = json['list'],
        title = json['title'];
}

class IItem {
  IItem({this.slot, this.isSelected = false});
  final String slot;
  bool isSelected;

  IItem.fromJson(Map<String, dynamic> json)
      : isSelected = json['isSelected'],
        slot = json['slot'];
}

class _TimeSlotState extends State<TimeSlot> {
  List<Time> slots;
  String time,selectedDate;
  int selectedIndex;
  bool isLoading;

  _TimeSlotState(this.selectedDate);
  getSlotEnable(item){

  }
  void _onTimeSelected(time, selectedIndex) {

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    var currentDate = formatter.format(DateTime.now());
    int currentHour = DateTime.now().hour;

    if(currentDate==selectedDate){
if(currentHour < int.parse(time.split(":")[0]) && time.split(" ")[1].toString()=="AM" ){

  setState(() {
    time = time;
  });
  final iItem =
  slots[selectedIndex].list.firstWhere((item) => item.slot == time);
  for(int i=0;i<slots.length;i++){
    if(selectedIndex==i){
      for(int j=0;j<slots[i].list.length;j++){
        if(iItem.slot==slots[i].list[j].slot){
          slots[i].list[j].isSelected=true;
        }else{
          slots[i].list[j].isSelected=false;
        }
      }
    }else{
      for(int j=0;j<slots[i].list.length;j++){
        slots[i].list[j].isSelected=false;
      }
    }

  }


  widget.setTime(time);
}else if(currentHour < int.parse(time.split(":")[0])+12 && time.split(" ")[1].toString()=="PM" ){
  print(" sonupm "+(int.parse(time.split(":")[0])+12).toString()  +" hh >> "+time.split(":")[0]+" hh ww>> "+time.split(" ")[1].toString());

  setState(() {
    time = time;
  });
  final iItem =
  slots[selectedIndex].list.firstWhere((item) => item.slot == time);
  for(int i=0;i<slots.length;i++){
    if(selectedIndex==i){
      for(int j=0;j<slots[i].list.length;j++){
        if(iItem.slot==slots[i].list[j].slot){
          slots[i].list[j].isSelected=true;
        }else{
          slots[i].list[j].isSelected=false;
        }
      }
    }else{
      for(int j=0;j<slots[i].list.length;j++){
        slots[i].list[j].isSelected=false;
      }
    }

  }

  widget.setTime(time);
}


    }else{
      setState(() {
        time = time;
      });

      final iItem =
      slots[selectedIndex].list.firstWhere((item) => item.slot == time);
      for(int i=0;i<slots.length;i++){
        if(selectedIndex==i){
          for(int j=0;j<slots[i].list.length;j++){
            if(iItem.slot==slots[i].list[j].slot){
              slots[i].list[j].isSelected=true;
            }else{
              slots[i].list[j].isSelected=false;
            }
          }
        }else{
          for(int j=0;j<slots[i].list.length;j++){
            slots[i].list[j].isSelected=false;
          }
        }

      }
      // if (iItem != null) {
      //   setState(() => iItem.isSelected = !iItem.isSelected);
      // }
      widget.setTime(time);
    }




    // final iItemSelected =
    //     slots[selectedIndex].list.firstWhere((item) => item.isSelected == true);
    // if (iItemSelected != null) {
    //   setState(() => iItemSelected.isSelected = false);
    // }

  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    slots = new List<Time>();

    Future.delayed(Duration.zero, () {
      final morningStartTime = TimeOfDay(hour: 6, minute: 0);
      final morningEndTime = TimeOfDay(hour: 11, minute: 0);

      final noonStartTime = TimeOfDay(hour: 12, minute: 0);
      final noonEndTime = TimeOfDay(hour: 18, minute: 0);

      final eveningStartTime = TimeOfDay(hour: 19, minute: 0);
      final eveningEndTime = TimeOfDay(hour: 21, minute: 0);
      final step = Duration(minutes: 60);

      final morningTime = getTimes(morningStartTime, morningEndTime, step)
          .map((tod) => formatTimeOfDay(tod)) // tod.format(context))
          .toList();
      final noonTime = getTimes(noonStartTime, noonEndTime, step)
          .map((tod) => formatTimeOfDay(tod)) // tod.format(context))
          .toList();
      final eveningTime = getTimes(eveningStartTime, eveningEndTime, step)
          .map((tod) => formatTimeOfDay(tod)) // tod.format(context))
          .toList();
      slots.add(
        Time.fromJson({
          'title': 'Morning',
          'list': List<IItem>.from(morningTime.map((item) {
            return IItem.fromJson({'slot': item, 'isSelected': false});
          }))
        }),
      );
      slots.add(
        Time.fromJson({
          'title': 'Afternoon',
          'list': List<IItem>.from(noonTime.map((item) {
            return IItem.fromJson({'slot': item, 'isSelected': false});
          }))
        }),
      );
      slots.add(
        Time.fromJson({
          'title': 'Evening',
          'list': List<IItem>.from(eveningTime.map((item) {
            return IItem.fromJson({'slot': item, 'isSelected': false});
          }))
        }),
      );
      print(slots.length);
      setState(() {
        isLoading = false;
      });
    });
  }

  Iterable<TimeOfDay> getTimes(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'SLOTS AVAILABLE',
              style: theme.textTheme.bodyText1.copyWith(
                  color: AppColors.black, fontWeight: FontWeight.w800),
            ),
          ),
          (isLoading)
              ? AppLoading()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: slots.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = slots[index];
                    return Stack(overflow: Overflow.visible, children: <Widget>[
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Sizes.MARGIN_20,
                              vertical: Sizes.MARGIN_10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: AppColors.drawerBackColor,
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: Sizes.MARGIN_20,
                                  vertical: Sizes.MARGIN_20),
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 7.0,
                                  crossAxisSpacing: 7.0,
                                  childAspectRatio: 2.0,
                                ),
                                itemCount: item.list.length,
                                itemBuilder: (BuildContext context, int i) {
                                  final iSlot = item.list[i];
                                  print(iSlot.isSelected);
                                  return InkWell(
                                      onTap: () {
                                        _onTimeSelected(iSlot.slot, index);
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              border: Border.all(
                                                width: 2.0,
                                                color: (iSlot.isSelected)
                                                    ? AppColors.primaryColor
                                                    : AppColors.drawerBackColor,
                                              )),
                                          child:
                                              Center(child: Text(iSlot.slot))));
                                },
                              ))),
                      Positioned(
                        left: 30,
                        child: Container(
                          width: 100,
                          height: 25,
                          decoration: BoxDecoration(
                            // border: Border.all(),
                            borderRadius: BorderRadius.circular(20.0),
                            color: AppColors.primaryColor,
                          ),
                          child: Center(
                              child: Text(item.title,
                                  style: theme.textTheme.caption.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700))),
                        ),
                      ),
                    ]);
                  }),
        ],
      ),
    );
  }
}
