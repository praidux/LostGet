part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

class EditPhoneNumberFocusNodeClickedEvent extends EditProfileEvent {
  final bool hasFocus;

  EditPhoneNumberFocusNodeClickedEvent(this.hasFocus);
}

class DateTimeSelectedEvent extends EditProfileEvent {
  final DateTime dateTime;

  DateTimeSelectedEvent(this.dateTime);
}

class BackButtonClickedEvent extends EditProfileEvent {}

class FullNameOnChangedEvent extends EditProfileEvent {
  final String fullName;

  FullNameOnChangedEvent(this.fullName);
}

class EmailOnChangedEvent extends EditProfileEvent {
  final String email;

  EmailOnChangedEvent(this.email);
}

class BiographyOnChangedEvent extends EditProfileEvent {
  final String biography;

  BiographyOnChangedEvent(this.biography);
}

class DateOfBirthOnChangedEvent extends EditProfileEvent {
  final String dateOfBirth;

  DateOfBirthOnChangedEvent(this.dateOfBirth);
}

class CountryCodeOnChangedEvent extends EditProfileEvent {
  final String countryCode;

  CountryCodeOnChangedEvent(this.countryCode);
}

class PhoneNumberOnChangedEvent extends EditProfileEvent {
  final String phoneNumber;

  PhoneNumberOnChangedEvent(this.phoneNumber);
}

class GenderOnChangedEvent extends EditProfileEvent {
  final String gender;

  GenderOnChangedEvent(this.gender);
}

class FetchProfileDataEvent extends EditProfileEvent {}

class ProfileDataLoadingEvent extends EditProfileEvent {}

class ProfileDataLoadedEvent extends EditProfileEvent {}
