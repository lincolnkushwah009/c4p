part of 'member_bloc.dart';

class MemberState extends Equatable {
  const MemberState({
    this.status = FormzStatus.pure,
    this.status1 = FormzStatus.pure,
    this.phone = const PhoneNumber.pure(),
    this.otp = const NotEmptyField.pure(),
    this.country_code = const NotEmptyField.pure(),
    this.type = const NotEmptyField.pure(),
  });

  final FormzStatus status;
  final FormzStatus status1;
  final PhoneNumber phone;
  final NotEmptyField otp;
  final NotEmptyField type;
  final NotEmptyField country_code;

  MemberState copyWith({
    FormzStatus status,
    FormzStatus status1,
    PhoneNumber phone,
    NotEmptyField otp,
    NotEmptyField country_code,
    NotEmptyField type,
  }) {
    return MemberState(
      status: status ?? this.status,
      status1: status1 ?? this.status1,
      phone: phone ?? this.phone,
      otp: otp ?? this.otp,
      country_code: country_code ?? this.country_code,
      type: type ?? this.type,
    );
  }

  @override
  List<Object> get props => [status, status1, phone, otp, country_code,type];
}
