part of 'medicine_list_bloc.dart';

abstract class MedicineListEvent extends Equatable {
  const MedicineListEvent();

  @override
  List<Object> get props => [];
}

class GetMedicine extends MedicineListEvent {
  const GetMedicine();

  @override
  List<Object> get props => [];
}
