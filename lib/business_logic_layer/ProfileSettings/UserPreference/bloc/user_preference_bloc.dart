import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../controller/Profile Settings/edit_profile_controller.dart';
import '../../../../models/user_profile.dart';

part 'user_preference_event.dart';
part 'user_preference_state.dart';

class UserPreferenceBloc
    extends Bloc<UserPreferenceEvent, UserPreferenceState> {
  UserPreferenceBloc() : super(UserPreferenceInitial()) {}

}
