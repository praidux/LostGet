import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lost_get/controller/Profile%20Settings/edit_profile_controller.dart';
import 'package:meta/meta.dart';

import '../../../models/user_profile.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileLoadedEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileLoadingState()) {
    on<EditProfileLoadedEvent>(editProfileLoadedEvent);
    on<FullNameControllerEvent>(fullNameControllerEvent);
    on<SaveButtonClickedSuccessEvent>(saveButtonClickedEvent);
  }

  FutureOr<void> editProfileLoadedEvent(
      EditProfileLoadedEvent event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoadingState());

    try {
      UserProfile userProfile = await EditProfileController().getUserData();
      if (userProfile != null) {
        emit(EditProfileLoadedState(userProfile));
      } else {
        emit(EditProfileErrorState("Edit Profile page can't load."));
      }
    } catch (e) {
      emit(EditProfileErrorState("Edit Profile page can't load."));
    }
  }

  FutureOr<void> fullNameControllerEvent(
      FullNameControllerEvent event, Emitter<EditProfileState> emit) {
    emit(FullNameControllerState(event.fullName));
  }

  FutureOr<void> saveButtonClickedEvent(
      SaveButtonClickedSuccessEvent event, Emitter<EditProfileState> emit) {
    print("summoned");
    emit(SaveButtonClickedSuccessState());
  }
}
