part of 'upload_report_bloc.dart';

class UploadReportState extends Equatable {
  const UploadReportState(
      {this.status = FormzStatus.pure,
      this.file,
      this.service,
      this.date = const NotEmptyField.pure(),
      this.member});

  final FormzStatus status;
  final ServiceType service;
  final NotEmptyField date;
  final FamilyMainResult member;
  final String file;

  UploadReportState copyWith({
    FormzStatus status,
    ServiceType service,
    NotEmptyField date,
    String file,
    FamilyMainResult member,
  }) {
    return UploadReportState(
      status: status ?? this.status,
      file: file ?? this.file,
      service: service ?? this.service,
      date: date ?? this.date,
      member: member ?? this.member,
    );
  }

  @override
  List<Object> get props => [status, service, date, member, file];
}
