part of 'drawer_bloc.dart';

abstract class DrawerEvent extends Equatable {
  const DrawerEvent();

  @override
  List<Object> get props => [];
}

// this is the event that's triggered when the user
// wants to change pages
class NavigateTo extends DrawerEvent {
  final DrawerItem destination;
  const NavigateTo(this.destination);
}
