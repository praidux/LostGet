import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../data_store_layer/repository/users_repository.dart';
import '../../../models/user_profile.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditPhoneNumberFocusNodeClickedEvent>(
        editPhoneNumberFocusNodeClickedEvent);
    on<DateTimeSelectedEvent>(dateTimeSelectedEvent);
    on<BackButtonClickedEvent>(backButtonClickedEvent);
    on<FullNameOnChangedEvent>(fullNameOnChangedEvent);
    on<EmailOnChangedEvent>(emailOnChangedEvent);
    on<BiographyOnChangedEvent>(biographyOnChangedEvent);
    on<PhoneNumberOnChangedEvent>(phoneNumberOnChangedEvent);
    on<CountryCodeOnChangedEvent>(countryCodeOnChangedEvent);
    on<DateOfBirthOnChangedEvent>(dateOfBirthOnChangedEvent);
    on<GenderOnChangedEvent>(genderOnChangedEvent);
    on<FetchProfileDataEvent>(fetchProfileDataEvent);
  }

  FutureOr<void> editPhoneNumberFocusNodeClickedEvent(
      EditPhoneNumberFocusNodeClickedEvent event,
      Emitter<EditProfileState> emit) {
    emit(EditPhoneNumberFocusNodeClickedState(event.hasFocus));
  }

  FutureOr<void> dateTimeSelectedEvent(
      DateTimeSelectedEvent event, Emitter<EditProfileState> emit) {
    emit(DateTimeSelectedState(event.dateTime));
  }

  FutureOr<void> backButtonClickedEvent(
      BackButtonClickedEvent event, Emitter<EditProfileState> emit) {
    emit(BackButtonClickedState());
  }

  FutureOr<void> fullNameOnChangedEvent(
      FullNameOnChangedEvent event, Emitter<EditProfileState> emit) {
    print("Date ${event.fullName}");
    emit(EditProfileState(fullName: event.fullName));
  }

  FutureOr<void> emailOnChangedEvent(
      EmailOnChangedEvent event, Emitter<EditProfileState> emit) {
    print("Date ${event.email}");
    emit(EditProfileState(emailAddress: event.email));
  }

  FutureOr<void> biographyOnChangedEvent(
      BiographyOnChangedEvent event, Emitter<EditProfileState> emit) {
    print("Date ${event.biography}");
    emit(EditProfileState(biography: event.biography));
  }

  FutureOr<void> phoneNumberOnChangedEvent(
      PhoneNumberOnChangedEvent event, Emitter<EditProfileState> emit) {
    print("Date ${event.phoneNumber}");
    emit(EditProfileState(phoneNumber: event.phoneNumber));
  }

  FutureOr<void> dateOfBirthOnChangedEvent(
      DateOfBirthOnChangedEvent event, Emitter<EditProfileState> emit) {
    print("Date ${event.dateOfBirth}");
    emit(EditProfileState(dateOfBirth: event.dateOfBirth));
  }

  FutureOr<void> genderOnChangedEvent(
      GenderOnChangedEvent event, Emitter<EditProfileState> emit) {
    print("Date ${event.gender}");
    emit(EditProfileState(gender: event.gender));
  }

  FutureOr<void> countryCodeOnChangedEvent(
      CountryCodeOnChangedEvent event, Emitter<EditProfileState> emit) {
    emit(EditProfileState(countryCode: event.countryCode));
  }

  Future<FutureOr<void>> fetchProfileDataEvent(
      FetchProfileDataEvent event, Emitter<EditProfileState> emit) async {
    String? email = FirebaseAuth.instance.currentUser?.email;

    if (email != null) {
      UserProfile userProfile = await UserRepository().getUserDetails(email);
      emit(ProfileDataLoadedState(userProfile));
    }
  }
}
