import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_phone_number_verification_event.dart';
part 'change_phone_number_verification_state.dart';

class ChangePhoneNumberVerificationBloc extends Bloc<ChangePhoneNumberVerificationEvent, ChangePhoneNumberVerificationState> {
  ChangePhoneNumberVerificationBloc() : super(ChangePhoneNumberVerificationInitial()) {
    on<ChangePhoneNumberVerificationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
