import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState()) {
    on<EmailOnChangedEvent>(emailOnChangedEvent);
    on<PasswordOnChangedEvent>(passwordOnChangedEvent);
    on<RegisterButtonClickedEvent>(registerButtonClickedEvent);
    on<EyeToggleViewClickedEvent>(eyeToggleViewClickedEvent);
  }

  FutureOr<void> emailOnChangedEvent(
      EmailOnChangedEvent event, Emitter<SignInState> emit) {
    print("email: ${event.email}");
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> passwordOnChangedEvent(
      PasswordOnChangedEvent event, Emitter<SignInState> emit) {
    print("password ${event.password}");
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> registerButtonClickedEvent(
      RegisterButtonClickedEvent event, Emitter<SignInState> emit) {
    emit(RegisterButtonClickedState());
  }

  FutureOr<void> eyeToggleViewClickedEvent(
      EyeToggleViewClickedEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(isHidden: !state.isHidden));
  }
}