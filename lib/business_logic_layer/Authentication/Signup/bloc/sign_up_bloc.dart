// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState()) {
    on<FirstNameOnChangedEvent>(firstNameOnChangedEvent);
    on<LastNameOnChangedEvent>(lastNameOnChangedEvent);
    on<EmailOnChangedEvent>(emailOnChangedEvent);
    on<PasswordOnChangedEvent>(passwordOnChangedEvent);
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<EyeToggleViewClickedEvent>(eyeToggleViewClickedEvent);
    on<NavigateToEmailVerificationEvent>(navigateToEmailVerificationEvent);
  }

  FutureOr<void> firstNameOnChangedEvent(
      FirstNameOnChangedEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(firstName: event.firstName));
    print("First Name: ${event.firstName}");
  }

  FutureOr<void> lastNameOnChangedEvent(
      LastNameOnChangedEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(lastName: event.lastName));
    print("Last Name: ${event.lastName}");
  }

  FutureOr<void> emailOnChangedEvent(
      EmailOnChangedEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(emailAddress: event.email));
    print("Email Address: ${event.email}");
  }

  FutureOr<void> passwordOnChangedEvent(
      PasswordOnChangedEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: event.password));
    print("Password: ${event.password}");
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<SignUpState> emit) {
    emit(LoginButtonClickedState());
  }

  FutureOr<void> eyeToggleViewClickedEvent(
      EyeToggleViewClickedEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(isHidden: !state.isHidden));
  }

  FutureOr<void> navigateToEmailVerificationEvent(
      NavigateToEmailVerificationEvent event, Emitter<SignUpState> emit) {
    emit(NavigateToEmailVerificationState(event.userCredential));
  }
}
