part of 'sign_up_bloc.dart';

class SignUpState {
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String password;
  bool isHidden;

  SignUpState({
    this.firstName = '',
    this.lastName = '',
    this.emailAddress = '',
    this.password = '',
    this.isHidden = true,
  });

  SignUpState copyWith(
      {String? firstName,
      String? lastName,
      String? emailAddress,
      String? password,
      bool? isHidden}) {
    return SignUpState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      isHidden: isHidden ?? this.isHidden,
    );
  }
}

class SignUpActionState extends SignUpState {}

class RegisterNowButtonClickedState extends SignUpActionState {}

class LoginButtonClickedState extends SignUpActionState {}
