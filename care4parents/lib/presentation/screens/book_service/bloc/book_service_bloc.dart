import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/appointment_params.dart';
import 'package:care4parents/domain/usecases/get_appointments.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/helper/validation/common.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'book_service_event.dart';
part 'book_service_state.dart';

class BookServiceBloc extends Bloc<BookServiceEvent, BookServiceState> {
  CreateService createService;
  BookServiceBloc({@required this.createService}) : super(BookServiceState()) {
    on<ServiceSpecialistChanged>(
      (event, emit) async {
        emit(_mapSpecialistChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<ServiceDateChanged>(
      (event, emit) async {
        emit(_mapDateChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<BookServiceSubmitted>(
      (event, emit) async {
        await _mapAppointmentSubmittedToState(event, state, emit);
      },
      transformer: sequential(),
    );
    on<ServiceMemberChanged>(
      (event, emit) async {
        emit(_maMemberChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<ServicePhoneChanged>(
      (event, emit) async {
        emit(_maPhoneChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<ServiceRemarkChanged>(
      (event, emit) async {
        emit(_maRemarkChangedToState(event, state));
      },
      transformer: sequential(),
    );
  }
  // @override
  // Stream<BookServiceState> mapEventToState(
  //   BookServiceEvent event,
  // ) async* {
  //   if (event is ServiceSpecialistChanged) {
  //     yield _mapSpecialistChangedToState(event, state);
  //   } else if (event is ServiceDateChanged) {
  //     yield _mapDateChangedToState(event, state);
  //   } else if (event is BookServiceSubmitted) {
  //     yield* _mapAppointmentSubmittedToState(event, state);
  //   } else if (event is ServiceMemberChanged) {
  //     yield _maMemberChangedToState(event, state);
  //   } else if (event is ServicePhoneChanged) {
  //     yield _maPhoneChangedToState(event, state);
  //   } else if (event is ServiceRemarkChanged) {
  //     yield _maRemarkChangedToState(event, state);
  //   }
  // }

  BookServiceState _mapSpecialistChangedToState(
    ServiceSpecialistChanged event,
    BookServiceState state,
  ) {
    final specialist = NotEmptyField.dirty(event.specialist);

    return state.copyWith(
      specialist: specialist,
      status: Formz.validate([state.date, specialist]),
    );
  }

  BookServiceState _maMemberChangedToState(
    ServiceMemberChanged event,
    BookServiceState state,
  ) {
    final member = event.member;
    print('member >>>>>>>>>>>>>>' + member.toString());
    final phone = PhoneNumber.dirty(member.family_member.phone);
    print(phone);
    return state.copyWith(
      member: member,
      phone: phone,
      status: Formz.validate([state.specialist, state.date]),
    );
  }

  BookServiceState _maPhoneChangedToState(
    ServicePhoneChanged event,
    BookServiceState state,
  ) {
    final phone = PhoneNumber.dirty(event.phone);

    return state.copyWith(
      phone: phone,
      status: Formz.validate([state.specialist, state.date]),
    );
  }

  BookServiceState _maRemarkChangedToState(
    ServiceRemarkChanged event,
    BookServiceState state,
  ) {
    final remark = NotEmptyField.dirty(event.remark);

    return state.copyWith(
      remark: remark,
    );
  }

  BookServiceState _mapDateChangedToState(
    ServiceDateChanged event,
    BookServiceState state,
  ) {
    final date = NotEmptyField.dirty(event.date);

    return state.copyWith(
      date: date,
      status: Formz.validate([state.specialist, date]),
    );
  }

  _mapAppointmentSubmittedToState(
    BookServiceSubmitted event,
    BookServiceState state,
    Emitter<BookServiceState> emit,
  ) async {
    if (state.status.isValidated) {
      if (state.member == null) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));
        try {
          String date = state.date.value.split(" ")[0];
          String time = state.date.value.split(" ")[1];
          String aaa = "";
          int end_time;
          String bbb;
          if (state.date.value.split(" ").length == 3) {
            aaa = state.date.value.split(" ")[2];

            int int_time = int.tryParse(time.split(":")[0]);
            int_time = int_time + 1;
            end_time = int_time > 12 ? int_time - 12 : int_time;
            bbb = int_time <= 12 ? 'AM' : 'PM';
          } else {
            var times = int.tryParse(time.split(":")[0]);

            int in_time = times > 12 ? times - 12 : times;
            aaa = times <= 12 ? 'AM' : 'PM';
            time = in_time.toString() + ":00";

            int int_times = times + 1;
            end_time = int_times > 12 ? int_times - 12 : int_times;
            bbb = int_times <= 12 ? 'AM' : 'PM';
          }
          print('$end_time:00 $bbb');
          // print('int_time' + int_time.toString());
          // n = DateFormat.jm(time);
          // print(DateFormat('yyyy-MMMM-dd hh:mm aaa')
          //     .parse(state.date.value.toString()));
          // String n =
          //     TimeOfDay.fromDateTime();
          // print('end_time' + end_time.toString());

          print({
            'appointDate': date,
            'patientId': state.member.family_member.id,
            'mobile': state.member.family_member.phone,
            'phone': state.phone.value,
            'speciality': state.specialist.value,
            'email': state.member.family_member.email,
            'timerange': '$time $aaa - $end_time:00 $bbb',
            'startappointdate': '$date $time $aaa',
            'endappointdate': '$date $end_time:00 $bbb',
            'remarks': state.remark.value,
          });
          await SharedPreferenceHelper.setBookServiceName(
              state.specialist.value.toString());
          final Either<AppError, ObjectCommonResult> eitherResponse =
              await createService(ServiceParams(
            bookingdate: date,
            patientId: state.member.family_member.id,
            mobile: state.member.family_member.phone,
            phone: state.phone.value,
            service: state.specialist.value,
            email: state.member.family_member.email,
            timerange: '$time $aaa -  $end_time:00 $bbb',
            startbookingdate: '$date $time $aaa',
            endbookingdate: '$date $end_time:00 $bbb',
            remarks: state.remark.value,
          ));

          print('eitherResponse >>>>>>' + eitherResponse.toString());
          emit(eitherResponse.fold(
            (l) {
              print('left error >>>>>');
              return state.copyWith(status: FormzStatus.submissionFailure);
            },
            (r) {
              var d = r.data as Map;
              print('d -------' + d.toString());
              SharedPreferenceHelper.setBookServiceIdPref(d['id']);
              return state.copyWith(status: FormzStatus.submissionSuccess);
            },
          ));
        } on Exception catch (_) {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      }
    } else {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
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
}
