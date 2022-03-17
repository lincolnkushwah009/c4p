part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  const EditProfileState(
      {this.status = FormzStatus.pure,
      this.profile_status = FormzStatus.pure,
      this.email = const Email.pure(),
      this.image,
      this.phone_number = const PhoneNumber.pure(),
      this.name = const Name.pure(),
        this.emailVerifyStatus = const Name.pure(),
      this.address = const Address.pure(),
      this.country = const Country.pure()});

  final FormzStatus status;
  final FormzStatus profile_status;
  final Email email;
  final PhoneNumber phone_number;
  final Name name;
  final Name emailVerifyStatus;
  final Country country;
  final Address address;
  final File image;

  EditProfileState copyWith(
      {FormzStatus status,
      FormzStatus profile_status,
      Email email,
      PhoneNumber phone_number,
      Name name,

      Country country,
      Address address,
        Name emailVerifyStatus,
      image}) {
    return EditProfileState(
      status: status ?? this.status,
      profile_status: profile_status ?? this.profile_status,
      email: email ?? this.email,
      phone_number: phone_number ?? this.phone_number,
      name: name ?? this.name,
      country: country ?? this.country,
      address: address ?? this.address,
      image: image ?? this.image,
      emailVerifyStatus: emailVerifyStatus ?? this.emailVerifyStatus,

    );
  }

  @override
  List<Object> get props => [
        profile_status,
        status,
        email,
        phone_number,
        name,
        country,
        address,
        image,emailVerifyStatus
      ];
}

class ProfileUpdated extends EditProfileState {
  final image;

  const ProfileUpdated({this.image}) : super();

  @override
  List<Object> get props => [image];
}
