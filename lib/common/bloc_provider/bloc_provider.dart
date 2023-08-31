import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lost_get/business_logic_layer/Authentication/Signup/bloc/sign_up_bloc.dart';
import 'package:lost_get/business_logic_layer/Authentication/Verification/bloc/email_verification_bloc.dart';
import 'package:lost_get/business_logic_layer/Dashboard/bloc/dashboard_bloc.dart';
import 'package:lost_get/business_logic_layer/EditProfile/ChangeProfile/bloc/change_profile_bloc.dart';
import 'package:lost_get/business_logic_layer/EditProfile/bloc/edit_profile_bloc.dart';
import 'package:lost_get/business_logic_layer/Onboard/bloc/onboard_bloc.dart';
import 'package:lost_get/business_logic_layer/ProfileSettings/Settings/bloc/settings_bloc.dart';
import 'package:lost_get/business_logic_layer/ProfileSettings/UserPreference/bloc/user_preference_bloc.dart';
import 'package:lost_get/business_logic_layer/ProfileSettings/bloc/profile_settings_bloc.dart';

import '../../business_logic_layer/Authentication/Signin/bloc/sign_in_bloc.dart';

class AppBlocProvider {
  static get allBlocProvider => [
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => EmailVerificationBloc()),
        BlocProvider(create: (context) => DashboardBloc()),
        BlocProvider(create: (context) => OnboardBloc()),
        BlocProvider(create: (context) => ProfileSettingsBloc()),
        BlocProvider(create: (context) => EditProfileBloc()),
        BlocProvider(create: (context) => ChangeProfileBloc()),
        BlocProvider(create: (context) => UserPreferenceBloc()),
        BlocProvider(create: (context) => SettingsBloc()),
      ];
}
