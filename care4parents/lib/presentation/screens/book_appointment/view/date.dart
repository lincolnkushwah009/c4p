import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

final kToday = DateTime.now();

final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class DatePage extends StatefulWidget {
  final Function setDate;
  const DatePage({Key key, this.setDate}) : super(key: key);

  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  String _selectedDate;
  // DateTime _focusedDay;

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _selectedDate = formatter.format(DateTime.now());
    _focusedDay = DateTime.now();
  }

  // void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
  //   final String date = formatter.format(selectedDay);
  //   setState(() {
  //     _selectedDate = date;
  //     _focusedDay = focusedDay;
  //   });
  //   widget.setDate(date);
  //   print(_selectedDate);
  // }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now().toUtc();
    // print('now------------: ${now.year}-${now.month}-${now.day}');
    return TableCalendar(
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      calendarStyle: CalendarStyle(
        defaultTextStyle: TextStyle(color: Colors.black),
        weekendTextStyle: TextStyle(color: Colors.black),
        outsideTextStyle: TextStyle(color: Colors.grey),
        // unavailableTextStyle: TextStyle(color: Colors.grey),
        // outsideWeekendStyle: TextStyle(color: Colors.grey),
      ),
      selectedDayPredicate: (day) {
        // Use `selectedDayPredicate` to determine which day is currently selected.
        // If this returns true, then `day` will be marked as selected.

        // Using `isSameDay` is recommended to disregard
        // the time-part of compared DateTime objects.
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _selectedDate = selectedDay.toString();
            _focusedDay = focusedDay;
          });
          final String date = formatter.format(selectedDay);
          widget.setDate(date);
        }
      },
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
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
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
        // markerBuilder: (context, date, events) {
        //   return Container(
        //     decoration: new BoxDecoration(
        //       color: AppColors.black,
        //       shape: BoxShape.circle,
        //     ),
        //     margin: const EdgeInsets.all(4.0),
        //     width: 4,
        //     height: 4,
        //   );
        // },
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
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    );

    //   TableCalendar(
    //     firstDay: DateTime.utc(now.year, now.month, now.day),
    //     lastDay: DateTime.utc(2025, 12, 31),
    //     startingDayOfWeek: StartingDayOfWeek.monday,
    //     calendarStyle: CalendarStyle(
    //       defaultTextStyle: TextStyle(color: Colors.black),
    //       weekendTextStyle: TextStyle(color: Colors.black),
    //       outsideTextStyle: TextStyle(color: Colors.grey),
    //       // unavailableTextStyle: TextStyle(color: Colors.grey),
    //       // outsideWeekendStyle: TextStyle(color: Colors.grey),
    //     ),
    //     daysOfWeekStyle: DaysOfWeekStyle(
    //       dowTextFormatter: (date, locale) {
    //         return DateFormat.E(locale)
    //             .format(date)
    //             .substring(0, 1)
    //             .toUpperCase();
    //       },
    //       weekdayStyle: TextStyle(color: AppColors.primaryColor),
    //       weekendStyle: TextStyle(color: AppColors.lightBlue),
    //     ),
    //     headerStyle: HeaderStyle(
    //         titleCentered: true,
    //         formatButtonVisible: false,
    //         titleTextStyle: Theme.of(context).textTheme.subtitle1.copyWith(
    //               color: AppColors.primaryColor,
    //               fontWeight: FontWeight.w800,
    //             )),
    //     onDaySelected: (date, DateTime focusedDay) {
    //       print('-------' + _focusedDay.toString());
    //       print('-------' + focusedDay.toString());

    //       _onDaySelected(date, focusedDay);
    //     },
    //     calendarBuilders: CalendarBuilders(
    //       todayBuilder: (context, date, _) {
    //         return Container(
    //           decoration: new BoxDecoration(
    //             border: Border.all(color: AppColors.black, width: 2.0),
    //             shape: BoxShape.circle,
    //           ),
    //           margin: const EdgeInsets.all(4.0),
    //           width: 100,
    //           height: 100,
    //           child: Center(
    //             child: Text(
    //               '${date.day}',
    //               style: TextStyle().copyWith(
    //                 color: AppColors.primaryColor,
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //       markerBuilder: (context, date, events) {
    //         return Container(
    //           decoration: new BoxDecoration(
    //             color: AppColors.black,
    //             shape: BoxShape.circle,
    //           ),
    //           margin: const EdgeInsets.all(4.0),
    //           width: 4,
    //           height: 4,
    //         );
    //       },
    //       selectedBuilder: (context, date, _) {
    //         return Container(
    //           decoration: new BoxDecoration(
    //             border: Border.all(color: AppColors.primaryColor, width: 2.0),
    //             shape: BoxShape.circle,
    //           ),
    //           margin: const EdgeInsets.all(4.0),
    //           width: 100,
    //           height: 100,
    //           child: Center(
    //             child: Text(
    //               '${date.day}',
    //               style: TextStyle(
    //                 fontSize: 16.0,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //     focusedDay: _focusedDay,
    //   );
  }
}
