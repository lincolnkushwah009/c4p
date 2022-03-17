import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(DrawerInitial(DrawerItem.home)) {
    on<NavigateTo>(
      (event, emit) async {
        if (event.destination != state.selectedItem) {
          emit(DrawerUpdate(event.destination));
        }
      },
      transformer: sequential(),
    );
  }

  // @override
  // Stream<DrawerState> mapEventToState(
  //   DrawerEvent event,
  // ) async* {
  //   if (event is NavigateTo) {
  //     if (event.destination != state.selectedItem) {
  //       yield DrawerUpdate(event.destination);
  //     }
  //   }
  // }
}
