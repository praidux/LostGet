part of 'edit_profile_bloc.dart';

class EditProfileState {
  final String fullName;
  final String emailAddress;
  final String phoneNumber;
  final String biography;
  final String dateOfBirth;
  final String gender;
  final String countryCode;

  EditProfileState({
    this.fullName = '',
    this.emailAddress = '',
    this.biography = '',
    this.dateOfBirth = '',
    this.phoneNumber = '',
    this.gender = '',
    this.countryCode = '',
  });

  EditProfileState copyWith({
    String? fullName,
    String? emailAddress,
    String? biography,
    String? dateOfBirth,
    String? phoneNumber,
    String? gender,
    String? countryCode,
  }) {
    return EditProfileState(
      fullName: fullName ?? this.fullName,
      emailAddress: emailAddress ?? this.emailAddress,
      biography: biography ?? this.biography,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      countryCode: countryCode ?? this.countryCode,
    );
  }
}

final class EditProfileInitial extends EditProfileState {}

class EditProfileActionState extends EditProfileState {}

class EditPhoneNumberFocusNodeClickedState extends EditProfileState {
  final bool hasFocus;

  EditPhoneNumberFocusNodeClickedState(this.hasFocus);
}

class DateTimeSelectedState extends EditProfileState {
  final DateTime dateTime;

  DateTimeSelectedState(this.dateTime);
}

class BackButtonClickedState extends EditProfileActionState {}

class ProfileDataLoadedState extends EditProfileState {
  final UserProfile userProfile;

  ProfileDataLoadedState(this.userProfile);
}

class ProfileDataLoadingState extends EditProfileActionState {}
