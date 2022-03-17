part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfileLoadEvent extends EditProfileEvent {
  final String email;
  final String name;
  final String phone_number;
  final String country;
  final String emailVerifyStatus;
  final String address;
  final File image;

  const EditProfileLoadEvent(
      this.email, this.name, this.phone_number, this.country, this.address,
      {this.image,this.emailVerifyStatus});

  @override
  List<Object> get props =>
      [email, name, phone_number, country, address, image,emailVerifyStatus];
}

class EditProfileEmailChanged extends EditProfileEvent {
  const EditProfileEmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class EditProfilePasswordChanged extends EditProfileEvent {
  const EditProfilePasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class EditProfileNameChanged extends EditProfileEvent {
  const EditProfileNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}
class EditProfileEmailVerifyChanged extends EditProfileEvent {
  const EditProfileEmailVerifyChanged(this.emailVerifyStatus);

  final String emailVerifyStatus;

  @override
  List<Object> get props => [emailVerifyStatus];
}
class EditProfilePhoneNumberChanged extends EditProfileEvent {
  const EditProfilePhoneNumberChanged(this.phone_number);

  final String phone_number;

  @override
  List<Object> get props => [phone_number];
}

class EditProfileAddress extends EditProfileEvent {
  const EditProfileAddress(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

class EditProfileCountry extends EditProfileEvent {
  const EditProfileCountry(this.country);

  final String country;

  @override
  List<Object> get props => [country];
}

class EditProfileSubmitted extends EditProfileEvent {
  const EditProfileSubmitted();
}
class EmailVerifySubmitted extends EditProfileEvent {
  const EmailVerifySubmitted();
}
class ProfileImage extends EditProfileEvent {
  const ProfileImage(this.file);

  final File file;

  @override
  List<Object> get props => [file];
}

class ProfileChanged extends EditProfileEvent {
  const ProfileChanged(this.image);

  final File image;

  @override
  List<Object> get props => [image];
}
