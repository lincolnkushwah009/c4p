part of 'member_bloc.dart';

abstract class MemberEvent extends Equatable {
  const MemberEvent();

  @override
  List<Object> get props => [];
}

class MemberPhoneNumberChanged extends MemberEvent {
  const MemberPhoneNumberChanged(this.phone,this.type);
  final String phone;
  final String type;
  @override
  String toString() => 'MemberPhoneNumberChanged $phone';

  @override
  List<Object> get props => [phone,type];
}

class MemberOtpChanged extends MemberEvent {
  const MemberOtpChanged(this.otp);
  final String otp;

  @override
  String toString() => 'MemberOtpChanged $otp';

  @override
  List<Object> get props => [otp];
}

class MemberPhoneSubmit extends MemberEvent {
  const MemberPhoneSubmit();
}

class MemberOtpSubmit extends MemberEvent {
  const MemberOtpSubmit();
}


class MemberCodeChanged extends MemberEvent {
  const MemberCodeChanged(this.country_code);
  final String country_code;

  @override
  List<Object> get props => [country_code];
}
class MemberTypeChanged extends MemberEvent {
  const MemberTypeChanged(this.type);
  final String type;

  @override
  List<Object> get props => [type];
}
