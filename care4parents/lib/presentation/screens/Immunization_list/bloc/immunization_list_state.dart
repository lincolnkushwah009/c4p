part of 'immunization_list_bloc.dart';

 class ImmunizationListState extends Equatable {

  const ImmunizationListState(  {this.status = FormzStatus.pure,

    this.msg = const NotEmptyField.pure(),
  this.fm_counts= const NotEmptyField.pure(),

  });
  final FormzStatus status;
  final NotEmptyField msg,fm_counts;
  ImmunizationListState copyWith({
    FormzStatus status,
    NotEmptyField msg,
    NotEmptyField fm_counts
  }) {
    return ImmunizationListState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
        fm_counts:fm_counts??this.fm_counts

    );
  }
  @override
  List<Object> get props => [status,msg,fm_counts];
}

class ImmunizationListInitial extends ImmunizationListState {}

class ImmunizationLoading extends ImmunizationListState {}

class Loaded extends ImmunizationListState {
  final List<ImmunizationData> invoices;

  const Loaded({
    this.invoices,
  }) : super();

  @override
  List<Object> get props => [
        invoices,
      ];
}



class LoadError extends ImmunizationListState {
  final AppErrorType errorType;

  const LoadError({
    @required this.errorType,
  }) : super();
}
