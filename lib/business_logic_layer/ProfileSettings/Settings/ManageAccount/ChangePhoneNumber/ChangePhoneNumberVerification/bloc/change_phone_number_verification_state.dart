part of 'change_phone_number_verification_bloc.dart';

sealed class ChangePhoneNumberVerificationState extends Equatable {
  const ChangePhoneNumberVerificationState();
  
  @override
  List<Object> get props => [];
}

final class ChangePhoneNumberVerificationInitial extends ChangePhoneNumberVerificationState {}
