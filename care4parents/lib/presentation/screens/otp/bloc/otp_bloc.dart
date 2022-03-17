import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial());

  @override
  Stream<OtpState> mapEventToState(
    OtpEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
