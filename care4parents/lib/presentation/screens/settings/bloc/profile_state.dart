part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoadError extends ProfileState {
  final AppErrorType errorType;

  const ProfileLoadError({
    @required this.errorType,
  }) : super();
}

class ProfileLoaded extends ProfileState {
  final UserEntity user;

  const ProfileLoaded({this.user}) : super();

  @override
  List<Object> get props => [user];
}
