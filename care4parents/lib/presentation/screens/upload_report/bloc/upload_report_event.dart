part of 'upload_report_bloc.dart';

abstract class UploadReportEvent extends Equatable {
  const UploadReportEvent();

  @override
  List<Object> get props => [];
}

class ServiceChanged extends UploadReportEvent {
  const ServiceChanged(this.service);
  final ServiceType service;

  @override
  List<Object> get props => [service];
}

class ServiceMemberChanged extends UploadReportEvent {
  const ServiceMemberChanged(this.member);
  final FamilyMainResult member;

  @override
  List<Object> get props => [member];
}

class FileChanged extends UploadReportEvent {
  const FileChanged(this.file);

  final String file;

  @override
  List<Object> get props => [file];
}

class ServiceDateChanged extends UploadReportEvent {
  const ServiceDateChanged(this.date);
  final String date;

  @override
  List<Object> get props => [date];
}

class UploadReportSubmitted extends UploadReportEvent {}
