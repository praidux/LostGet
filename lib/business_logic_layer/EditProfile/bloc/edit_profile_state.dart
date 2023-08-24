part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileState {}

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
