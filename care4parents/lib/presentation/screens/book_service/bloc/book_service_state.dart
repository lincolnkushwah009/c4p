part of 'book_service_bloc.dart';

class BookServiceState extends Equatable {
  const BookServiceState(
      {this.status = FormzStatus.pure,
      this.specialist = const NotEmptyField.pure(),
      this.date = const NotEmptyField.pure(),
      this.phone = const PhoneNumber.pure(),
      this.remark = const NotEmptyField.pure(),
      this.member});

  final FormzStatus status;
  final NotEmptyField specialist;
  final NotEmptyField date;
  final PhoneNumber phone;
  final NotEmptyField remark;
  final FamilyMainResult member;

  BookServiceState copyWith({
    FormzStatus status,
    NotEmptyField specialist,
    NotEmptyField date,
    PhoneNumber phone,
    NotEmptyField remark,
    FamilyMainResult member,
  }) {
    return BookServiceState(
      status: status ?? this.status,
      specialist: specialist ?? this.specialist,
      date: date ?? this.date,
      phone: phone ?? this.phone,
      remark: remark ?? this.remark,
      member: member ?? this.member,
    );
  }

  @override
  List<Object> get props => [status, specialist, date, member, phone, remark];
}
