part of 'profile_settings_bloc.dart';

@immutable
sealed class ProfileSettingsEvent {}

class EditProfileButtonClickedEvent extends ProfileSettingsEvent {}

class SignOutEvent extends ProfileSettingsEvent {}
