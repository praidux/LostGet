import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_settings_event.dart';
part 'profile_settings_state.dart';

class ProfileSettingsBloc
    extends Bloc<ProfileSettingsEvent, ProfileSettingsState> {
  ProfileSettingsBloc() : super(ProfileSettingsInitial()) {
    on<EditProfileButtonClickedEvent>(editProfileButtonClickedEvent);
  }

  FutureOr<void> editProfileButtonClickedEvent(
      EditProfileButtonClickedEvent event, Emitter<ProfileSettingsState> emit) {
    emit(EditProfileButtonClickedState());
  }
}
