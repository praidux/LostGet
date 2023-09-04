import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lost_get/controller/Settings/Manage%20Account/ChangePhoneNumber/change_phone_number_controller.dart';

part 'change_phone_number_event.dart';
part 'change_phone_number_state.dart';

class ChangePhoneNumberBloc
    extends Bloc<ChangePhoneNumberEvent, ChangePhoneNumberState> {
  ChangePhoneNumberBloc() : super(ChangePhoneNumberInitial()) {
    on<AcquirePhoneNumberEvent>(acquirePhoneNumberEvent);
    on<SaveButtonClickedEvent>(saveButtonClickedEvent);
    on<ContinueButtonClickedEvent>(continueButtonClickedEvent);
    on<ContinueButtonClickedErrorEvent>(continueButtonClickedErrorEvent);
  }

  final ChangePhoneNumberController _changePhoneNumberController =
      ChangePhoneNumberController();
  Future<FutureOr<void>> acquirePhoneNumberEvent(AcquirePhoneNumberEvent event,
      Emitter<ChangePhoneNumberState> emit) async {
    try {
      emit(AcquirePhoneNumberLoadingState());
      ChangePhoneNumberController changePhoneNumberController =
          ChangePhoneNumberController();
      String phoneNumber =
          await changePhoneNumberController.getUserPhoneNumber();
      String isoCountryCode =
          await changePhoneNumberController.getPhoneIsoCountry(phoneNumber);
      emit(AcquirePhoneNumberSuccessState(phoneNumber, isoCountryCode));
    } catch (e) {
      emit(AcquirePhoneNumberErrorState(e.toString()));
    }
  }

  Future<FutureOr<void>> saveButtonClickedEvent(SaveButtonClickedEvent event,
      Emitter<ChangePhoneNumberState> emit) async {
    emit(ContinueButtonClickedLoadingState());
    var result = await ChangePhoneNumberController()
        .updatePhoneNumber(event.oldPhoneNumber, event.newPhoneNumber);
    if (result == true) {
      emit(ContinueButtonClickedSuccessState());
    } else {}
  }

  FutureOr<void> continueButtonClickedEvent(
      ContinueButtonClickedEvent event, Emitter<ChangePhoneNumberState> emit) {
    _changePhoneNumberController.phoneNumberVerification(event.phoneNumber);
    emit(ContinueButtonClickedState());
  }

  FutureOr<void> continueButtonClickedErrorEvent(
      ContinueButtonClickedErrorEvent event,
      Emitter<ChangePhoneNumberState> emit) {
    emit(ContinueButtonClickedErrorState());
  }
}
