part of 'movie_backdrop_bloc.dart';

abstract class MovieBackdropState extends Equatable {
  const MovieBackdropState();

  @override
  List<Object> get props => [];
}

class MovieBackdropInitial extends MovieBackdropState {}

class MovieBackdropChanged extends MovieBackdropState {
  final ActivityEntity activityEntity;

  const MovieBackdropChanged(this.activityEntity);

  @override
  List<Object> get props => [activityEntity];
}
