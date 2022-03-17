part of 'bottom_navigation_bloc.dart';

@immutable
abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex});

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';
  @override
  List<Object> get props => [currentIndex];
}

class PageLoading extends BottomNavigationState {
  @override
  String toString() => 'PageLoading';
}

class DashboardPageLoaded extends BottomNavigationState {
  // final String text;

  DashboardPageLoaded();

  // @override
  // String toString() => 'FirstPageLoaded with text: $text';
  @override
  List<Object> get props => [];
}

class AppointmentPageLoaded extends BottomNavigationState {
  // final String text;

  AppointmentPageLoaded();

  // @override
  // String toString() => 'FirstPageLoaded with text: $text';
  @override
  List<Object> get props => [];
}

class ReportsPageLoaded extends BottomNavigationState {
  // final int number;

  ReportsPageLoaded();

  // @override
  // String toString() => 'SecondPageLoaded with number: $number';
  @override
  List<Object> get props => [];
}

class UploadPageLoaded extends BottomNavigationState {
  // final int number;

  UploadPageLoaded();

  // @override
  // String toString() => 'SecondPageLoaded with number: $number';
  @override
  List<Object> get props => [];
}

class RecordVitalPageLoaded extends BottomNavigationState {
  // final int number;

  RecordVitalPageLoaded();

  // @override
  // String toString() => 'SecondPageLoaded with number: $number';
  @override
  List<Object> get props => [];
}
