part of 'medicine_list_bloc.dart';

abstract class MedicineListState extends Equatable {
  const MedicineListState();

  @override
  List<Object> get props => [];
}

class MedicineListInitial extends MedicineListState {}

class MedicineLoading extends MedicineListState {}

class Loaded extends MedicineListState {
  final List<MedicineData> invoices;

  const Loaded({
    this.invoices,
  }) : super();

  @override
  List<Object> get props => [
        invoices,
      ];
}

class LoadError extends MedicineListState {
  final AppErrorType errorType;

  const LoadError({
    @required this.errorType,
  }) : super();
}
