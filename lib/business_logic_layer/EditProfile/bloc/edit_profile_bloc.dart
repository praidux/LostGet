import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditPhoneNumberFocusNodeClickedEvent>(
        editPhoneNumberFocusNodeClickedEvent);
    on<DateTimeSelectedEvent>(dateTimeSelectedEvent);
  }

  FutureOr<void> editPhoneNumberFocusNodeClickedEvent(
      EditPhoneNumberFocusNodeClickedEvent event,
      Emitter<EditProfileState> emit) {
    emit(EditPhoneNumberFocusNodeClickedState(event.hasFocus));
  }

  FutureOr<void> dateTimeSelectedEvent(
      DateTimeSelectedEvent event, Emitter<EditProfileState> emit) {
    print("I survived ${event.dateTime}");
    emit(DateTimeSelectedState(event.dateTime));
  }
}
