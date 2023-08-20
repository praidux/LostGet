part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class FirstNameOnChangedEvent extends SignUpEvent {
  final String firstName;

  FirstNameOnChangedEvent(this.firstName);
}

class LastNameOnChangedEvent extends SignUpEvent {
  final String lastName;

  LastNameOnChangedEvent(this.lastName);
}

class EmailOnChangedEvent extends SignUpEvent {
  final String email;

  EmailOnChangedEvent(this.email);
}

class PasswordOnChangedEvent extends SignUpEvent {
  final String password;

  PasswordOnChangedEvent(this.password);
}

class LoginButtonClickedEvent extends SignUpEvent {}

class EyeToggleViewClickedEvent extends SignUpEvent {}
