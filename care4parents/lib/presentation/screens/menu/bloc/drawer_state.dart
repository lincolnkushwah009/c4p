part of 'drawer_bloc.dart';

abstract class DrawerState extends Equatable {
  final DrawerItem selectedItem;

  const DrawerState(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}

class DrawerInitial extends DrawerState {
  DrawerInitial(DrawerItem selectedItem) : super(selectedItem);
}

class DrawerUpdate extends DrawerState {
  final DrawerItem selectedItem;

  DrawerUpdate(this.selectedItem) : super(selectedItem);
}

enum DrawerItem {
  header,
  home,
  dashboard,
  members,
  actives,
  valueAdded,
  immunization,
  medicine,
  settings,
  subscription,
  faq,
  contacts,
  logout,
  my_family,
  service_request
}
