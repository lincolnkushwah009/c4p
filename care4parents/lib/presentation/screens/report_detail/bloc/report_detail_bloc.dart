import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'report_detail_event.dart';
part 'report_detail_state.dart';

class ReportDetailBloc extends Bloc<ReportDetailEvent, ReportDetailState> {
  ReportDetailBloc() : super(ReportDetailInitial());

  @override
  Stream<ReportDetailState> mapEventToState(
    ReportDetailEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
