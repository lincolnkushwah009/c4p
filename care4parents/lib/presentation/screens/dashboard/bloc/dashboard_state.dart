part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class PageLoading extends DashboardState {
  @override
  String toString() => 'PageLoading';
}

class LoadedFamilyList extends DashboardState {
  final List<FamilyMainResult> userList;
  final int selectedId;

  LoadedFamilyList({this.userList, this.selectedId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoadedFamilyList &&
          runtimeType == other.runtimeType &&
          userList == other.userList &&
          selectedId == other.selectedId;

  @override
  int get hashCode => selectedId.hashCode;
}

class UpdateSelectedFamily extends DashboardState {
  final int selectedId;
  final List<FamilyMainResult> userList;
  UpdateSelectedFamily({this.userList, this.selectedId});
}

class FamilyLoadError extends DashboardState {
  final AppErrorType errorType;

  FamilyLoadError({
    @required this.errorType,
  });
}
