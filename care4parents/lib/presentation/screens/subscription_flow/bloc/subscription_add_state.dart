// part of 'purchagePlan_list_bloc.dart';
//
// import 'package:care4parents/data/models/ImmunizationModel.dart';
// import 'package:care4parents/domain/entities/app_error.dart';
// import 'package:equatable/equatable.dart';
//
// abstract class ImmunizationListState extends Equatable {
//   const ImmunizationListState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class ImmunizationListInitial extends ImmunizationListState {}
//
// class ImmunizationLoading extends ImmunizationListState {}
//
// class Loaded extends ImmunizationListState {
//   final List<ImmunizationData> invoices;
//
//   const Loaded({
//     this.invoices,
//   }) : super();
//
//   @override
//   List<Object> get props => [
//     invoices,
//   ];
// }
//
// class UserPPLoaded extends ImmunizationListState {
//   final String fm_count;
//
//   const UserPPLoaded({
//     this.fm_count,
//   }) : super();
//
//   @override
//   List<Object> get props => [
//     fm_count,
//   ];
// }
//
// class LoadError extends ImmunizationListState {
//   final AppErrorType errorType;
//
//   const LoadError({
//     @required this.errorType,
//   }) : super();
// }
