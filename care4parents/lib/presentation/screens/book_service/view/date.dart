import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class DatePage extends StatefulWidget {
  final Function setDate;
  const DatePage({Key key, this.setDate}) : super(key: key);

  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  String _selectedDate;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
  }

  void _onDaySelected(DateTime day, DateTime events) {
    final String date = formatter.format(day);
    setState(() {
      _selectedDate = date;
    });
    widget.setDate(date);
    print(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        defaultTextStyle: TextStyle(color: Colors.black),
        weekendTextStyle: TextStyle(color: Colors.black),
        outsideTextStyle: TextStyle(color: Colors.grey),
        // unavailableStyle: TextStyle(color: Colors.grey),
        // outsideWeekendStyle: TextStyle(color: Colors.grey),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextFormatter: (date, locale) {
          return DateFormat.E(locale)
              .format(date)
              .substring(0, 1)
              .toUpperCase();
        },
        weekdayStyle: TextStyle(color: AppColors.primaryColor),
        weekendStyle: TextStyle(color: AppColors.lightBlue),
      ),
      headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: Theme.of(context).textTheme.subtitle1.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w800,
              )),
      onDaySelected: (date, event) {
        print(date);

        _onDaySelected(date, event);
      },
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, date, _) {
          return Container(
            decoration: new BoxDecoration(
              border: Border.all(color: AppColors.black, width: 2.0),
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.all(4.0),
            width: 100,
            height: 100,
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          );
        },
        markerBuilder: (
          context,
          date,
          events,
        ) {
          return Container(
            decoration: new BoxDecoration(
              color: AppColors.black,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.all(4.0),
            width: 4,
            height: 4,
          );
        },
        selectedBuilder: (context, date, _) {
          return Container(
            decoration: new BoxDecoration(
              border: Border.all(color: AppColors.primaryColor, width: 2.0),
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.all(4.0),
            width: 100,
            height: 100,
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
