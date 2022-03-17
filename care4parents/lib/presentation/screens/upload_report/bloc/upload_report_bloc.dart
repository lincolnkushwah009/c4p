import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:care4parents/data/data_sources/other_remote_data_source.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/type_params.dart';
import 'package:care4parents/helper/validation/common.dart';
import 'package:care4parents/presentation/screens/upload_report/view/upload_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'upload_report_event.dart';
part 'upload_report_state.dart';

class UploadReportBloc extends Bloc<UploadReportEvent, UploadReportState> {
  OtherRemoteDataSource otherRemoteDataSource;
  DateFormat dFormat = DateFormat('yyyy-MM-dd');
  DateTime now = DateTime.now();
  // String date = dFormat.format(now);

  UploadReportBloc({@required this.otherRemoteDataSource})
      : super(UploadReportState()) {
    on<ServiceMemberChanged>(
      (event, emit) async {
        emit(_maMemberChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<ServiceChanged>(
      (event, emit) async {
        emit(_mapServiceChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<ServiceDateChanged>(
      (event, emit) async {
        emit(_mapDateChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<UploadReportSubmitted>(
      (event, emit) async {
        await _mapAppointmentSubmittedToState(event, state, emit);
      },
      transformer: sequential(),
    );
    on<FileChanged>(
      (event, emit) async {
        emit(_maFilePickerToState(event, state));
      },
      transformer: sequential(),
    );
  }
  // @override
  // Stream<UploadReportState> mapEventToState(
  //   UploadReportEvent event,
  // ) async* {
  //   if (event is ServiceChanged) {
  //     yield _mapServiceChangedToState(event, state);
  //   } else if (event is ServiceDateChanged) {
  //     yield _mapDateChangedToState(event, state);
  //   } else if (event is UploadReportSubmitted) {
  //     yield* _mapAppointmentSubmittedToState(event, state);
  //   } else if (event is ServiceMemberChanged) {
  //     yield _maMemberChangedToState(event, state);
  //   } else if (event is FileChanged) {
  //     yield _maFilePickerToState(event, state);
  //   }
  // }

  UploadReportState _maFilePickerToState(
    FileChanged event,
    UploadReportState state,
  ) {
    final String filePath = event.file;
    print('filePath ===========' + filePath);
    return state.copyWith(
      file: filePath,
    );
  }

  UploadReportState _mapServiceChangedToState(
    ServiceChanged event,
    UploadReportState state,
  ) {
    print('event.service.id' + event.service.id.toString());
    final service = event.service;

    return state.copyWith(
      service: service,
      // status: Formz.validate([state.date, service]),
    );
  }

  UploadReportState _maMemberChangedToState(
    ServiceMemberChanged event,
    UploadReportState state,
  ) {
    print('member*********************' +
        event.member.family_member_id.toString());
    final member = event.member;
    print(state.member);
    return state.copyWith(
      member: member,
      // status: Formz.validate([state.service, state.date]),
    );
  }

  UploadReportState _mapDateChangedToState(
    ServiceDateChanged event,
    UploadReportState state,
  ) {
    final date = NotEmptyField.dirty(event.date);

    return state.copyWith(
      date: date,
      // status: Formz.validate([state.service, date]),
    );
  }

  _mapAppointmentSubmittedToState(
    UploadReportSubmitted event,
    UploadReportState state,
    Emitter<UploadReportState> emit,
  ) async {
    if (state.file != null && state.member != null) {
      print({
        'family_member': state.member.family_member.id,
        'service': state.service != null ? state.service.id : 3,
        'report_date':
            state.date.value != '' ? state.date.value : dFormat.format(now),
        'doc_': state.file
      });
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final Either<AppError, ObjectCommonResult> eitherResponse =
            await otherRemoteDataSource.uploadReport(ServiceUploadParams(
                member_name: state.member.family_member != null
                    ? state.member.family_member.name
                    : '',
                member_phone: (state.member.family_member != null &&
                        state.member.family_member.phone != null)
                    ? state.member.family_member.phone
                    : '',
                family_member: state.member.family_member.id,
                service: state.service != null ? state.service.id : 3,
                report_date: state.date.value != ''
                    ? state.date.value
                    : dFormat.format(now),
                document: state.file));

        print('eitherResponse >>>>>>' + eitherResponse.toString());
        emit(eitherResponse.fold(
          (l) {
            print('left error >>>>>');
            return state.copyWith(status: FormzStatus.submissionFailure);
          },
          (r) {
            return state.copyWith(status: FormzStatus.submissionSuccess);
          },
        ));
      } on Exception catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
