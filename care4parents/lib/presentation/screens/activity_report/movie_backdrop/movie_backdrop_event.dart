part of 'movie_backdrop_bloc.dart';

abstract class MovieBackdropEvent extends Equatable {
  const MovieBackdropEvent();

  @override
  List<Object> get props => [];
}

class MovieBackdropChangedEvent extends MovieBackdropEvent {
  final ActivityEntity activityEntity;

  const MovieBackdropChangedEvent(this.activityEntity);

  @override
  List<Object> get props => [activityEntity];
}
