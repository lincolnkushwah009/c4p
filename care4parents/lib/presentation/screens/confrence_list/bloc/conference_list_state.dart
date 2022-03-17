part of 'conference_list_bloc.dart';

abstract class ConferenceListState extends Equatable {
  const ConferenceListState();

  @override
  List<Object> get props => [];
}

class ConferenceListInitial extends ConferenceListState {}

class Loading extends ConferenceListState {}

class Loaded extends ConferenceListState {
  final List<MedicineData> invoices;

  const Loaded({
    this.invoices,
  }) : super();

  @override
  List<Object> get props => [
        invoices,
      ];
}

class LoadError extends ConferenceListState {
  final AppErrorType errorType;

  const LoadError({
    @required this.errorType,
  }) : super();
}
