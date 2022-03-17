import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/data_sources/other_remote_data_source.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/page_result.dart';
import 'package:care4parents/data/models/report_detail.dart';
import 'package:care4parents/data/models/trend_main.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

part 'other_state.dart';

class OtherCubit extends Cubit<OtherState> {
  OtherRemoteDataSource otherDataSource;

  OtherCubit({@required this.otherDataSource}) : super(OtherInitial());

  Future<void> getPage(String page_name) async {
    try {
      emit(Loading());
      final Either<AppError, PageResult> eitherResponse =
          await otherDataSource.getPage(page_name);
      eitherResponse.fold(
        (l) {
          print('left error >>>>>');
          emit(Error(l.message));
        },
        (r) {
          print(r);
          if (page_name == 'banners') {
            final data = json.decode(r.data);
            print(data);
            Banners b = Banners.fromJson(data);
            SharedPreferenceHelper.setBannersPref(b);
            emit(LoadedBanner(b));
          } else {
            emit(Loaded(r));
          }
        },
      );
    } on Exception catch (_) {
      emit(Error('Couldn\'t fetch'));
    }
  }

  Future<void> getPageHeader(String page_name) async {
    try {
      emit(Loading());
      final Either<AppError, PageResult> eitherResponse =
          await otherDataSource.getPage(page_name);
      eitherResponse.fold(
        (l) {
          print('left error >>>>>');
          emit(Error(l.message));
        },
        (r) {
          print(r);
          final data = json.decode(r.data);
          print(data);

          List<Faq> list = List<Faq>.from(
              data.map((item) => Faq.fromJson({...item, 'show': false})));
          emit(LoadedFaq(list));
        },
      );
    } on Exception catch (_) {
      emit(Error('Couldn\'t fetch'));
    }
  }

  Future<void> getOcrSearch(String query) async {
    try {
      emit(Loading());
      FamilyMainResult member =
          await SharedPreferenceHelper.getSelectedFamilyPref();
      final Either<AppError, List<DataMain>> eitherResponse =
          await otherDataSource.getOcrSearch(member.family_member.id, query);
      eitherResponse.fold(
        (l) {
          print('left error >>>>>');
          emit(Error(l.message));
        },
        (r) {
          emit(LoadedVital(r));
        },
      );
    } on Exception catch (_) {
      emit(Error('Couldn\'t fetch'));
    }
  }

  Future<void> getTrendReport(String unique_key, int patient_id) async {
    try {
      // final Trend dummy_trend = Trend(uniqueKey: "GLUCOSE_FASTING", tests: [
      //   "GLUCOSE, FASTING (F), PLASMA",
      //   "Glucose (Fasting)",
      //   "Glucose (Fasting)"
      // ], dates: [
      //   "2021-07-22T00:00:00.000Z",
      //   "2021-07-21T00:00:00.000Z",
      //   "2021-07-20T00:00:00.000Z"
      // ], values: [
      //   "93",
      //   "132",
      //   "132"
      // ], units: [
      //   "mg/dL",
      //   "mg/dL",
      //   "mg/dL"
      // ], intervals: [
      //   "70.00 - 100.00",
      //   "74-99",
      //   "74-99"
      // ]);
      // DateFormat dateFormat = DateFormat("yyyy-MM-dd");

      emit(Loading());
      // FamilyMainResult member =
      //     await SharedPreferenceHelper.getSelectedFamilyPref();
      final Either<AppError, TrendMain> eitherResponse =
          await otherDataSource.getTrend(patient_id, unique_key);
      eitherResponse.fold(
        (l) {
          print('left error getTrendReport>>>>>');
          emit(Error(l.message));
        },
        (r) {
          List<Report> data = [];
          Trend trend = r.data;

          print('is number =====>' +
              isNumericUsing_tryParse(trend.values[0]).toString());

          if (!trend.dates.isEmpty &&
              !trend.values.isEmpty &&
              isNumericUsing_tryParse(trend.values[0])) {
            trend.dates.asMap().forEach((index, value) async =>
                data.add(Report(date: value, value: trend.values[index])));
            emit(LoadedTrend(data));
          } else {
            emit(Error('Couldn\'t fetch'));
          }
        },
      );
    } on Exception catch (_) {
      emit(Error('Couldn\'t fetch'));
    }
  }
}

// bool isInteger(num value) => (value % 1) == 0;
bool isNumericUsing_tryParse(String string) {
  // Null or empty string is not a number
  if (string == null || string.isEmpty) {
    return false;
  }

  // Try to parse input string to number.
  // Both integer and double work.
  // Use int.tryParse if you want to check integer only.
  // Use double.tryParse if you want to check double only.
  final number = num.tryParse(string);

  if (number == null) {
    return false;
  }

  return true;
}

class Report {
  String date;
  String value;
  Report({this.date, this.value});
}

class Faq {
  Faq({this.header, this.content, this.show = false});
  final String header;
  final String content;
  bool show;
  // final int age;
  // named constructor
  Faq.fromJson(Map<String, dynamic> json)
      : header = json['header'],
        content = json['content'],
        show = json['show'];
  // age = json['age'];
  // method
  Map<String, dynamic> toJson() {
    return {
      'header': header,
      'content': content,
      'show': show,
    };
  }
}

class Banners {
  Banners({this.banners, this.whychoose});
  final List<dynamic> banners;
  final List<dynamic> whychoose;
  // final int age;
  // named constructor
  Banners.fromJson(Map<String, dynamic> json)
      : banners = json['banners'],
        whychoose = json['whychoose'];
  // age = json['age'];
  // method
  Map<String, dynamic> toJson() {
    return {'banners': banners, 'whychoose': whychoose};
  }
}
