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
