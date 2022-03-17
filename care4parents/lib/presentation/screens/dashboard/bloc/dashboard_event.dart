part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class GetFamilyList extends DashboardEvent {
  @override
  String toString() => 'GetFamilyList';
}
class GetMemberList extends DashboardEvent {
  @override
  String toString() => 'GetFamilyList';
}

class ToggleEvent extends DashboardEvent {
  @override
  String toString() => 'GetFamilyList';

  @override
  List<Object> get props => [];
}

class UpdateSelectedFamilyMemberId extends DashboardEvent {
  UpdateSelectedFamilyMemberId(this.member, this.selectedFamilyMemberId);
  final int selectedFamilyMemberId;
  final FamilyMainResult member;

  @override
  String toString() => 'UpdateSelectedFamilyMemberId $selectedFamilyMemberId';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateSelectedFamilyMemberId &&
          runtimeType == other.runtimeType &&
          selectedFamilyMemberId == other.selectedFamilyMemberId &&
          member == other.member;

  @override
  int get hashCode => selectedFamilyMemberId.hashCode;
}

class LoadFamilyList extends DashboardEvent {
  LoadFamilyList({this.userList, this.selectedId});

  final int selectedId;
  final List<FamilyMainResult> userList;

  @override
  String toString() => 'LoadedFamilyList $selectedId';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoadFamilyList &&
          runtimeType == other.runtimeType &&
          selectedId == other.selectedId &&
          userList == other.userList;

  @override
  int get hashCode => selectedId.hashCode;
}
