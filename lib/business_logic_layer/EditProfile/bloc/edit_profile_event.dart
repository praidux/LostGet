part of 'edit_profile_bloc.dart';

class EditProfileLoadedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FullNameControllerEvent extends EditProfileLoadedEvent {
  final String fullName;

  FullNameControllerEvent(this.fullName);

  @override
  List<Object?> get props => [fullName];
}

final class BackButtonPressedEvent extends EditProfileLoadedEvent {}

final class SaveButtonClickedSuccessEvent extends EditProfileLoadedEvent {}

