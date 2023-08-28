part of 'profile_settings_bloc.dart';

@immutable
sealed class ProfileSettingsState {}

final class ProfileSettingsInitial extends ProfileSettingsState {}

class ProfileSettingsActionState extends ProfileSettingsState {}

class EditProfileButtonClickedState extends ProfileSettingsActionState {}

class SignOutState extends ProfileSettingsState {}
