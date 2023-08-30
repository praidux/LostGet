part of 'user_preference_bloc.dart';

sealed class UserPreferenceState extends Equatable {
  const UserPreferenceState();

  @override
  List<Object> get props => [];
}

final class UserPreferenceInitial extends UserPreferenceState {}
