part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfile extends ProfileEvent {
  const GetProfile();

  @override
  List<Object> get props => [];
}

class EditUser extends ProfileEvent {
  const EditUser();

  @override
  List<Object> get props => [];
}
