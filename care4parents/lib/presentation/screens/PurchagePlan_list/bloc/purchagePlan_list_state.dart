part of 'purchagePlan_list_bloc.dart';

abstract class PurchagePlanListState extends Equatable {
  const PurchagePlanListState();

  @override
  List<Object> get props => [];
}

class ImmunizationListInitial extends PurchagePlanListState {}

class ImmunizationLoading extends PurchagePlanListState {}

class Loaded extends PurchagePlanListState {
  final List<Package> packageList;

  const Loaded({
    this.packageList,
  }) : super();

  @override
  List<Object> get props => [
    packageList,
      ];
}

class UserPPLoaded extends PurchagePlanListState {
  final String fm_count;

  const UserPPLoaded({
    this.fm_count,
  }) : super();

  @override
  List<Object> get props => [
    fm_count,
  ];
}

class LoadError extends PurchagePlanListState {
  final AppErrorType errorType;

  const LoadError({
    @required this.errorType,
  }) : super();
}
