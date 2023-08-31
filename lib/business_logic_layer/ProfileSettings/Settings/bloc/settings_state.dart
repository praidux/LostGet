part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class UserPreferenceButtonClickedState extends SettingsState {}

final class ReleasedButtonState extends SettingsState {}
