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
import 'package:lost_get/business_logic_layer/Provider/change_theme_mode.dart';
import 'package:provider/provider.dart';

import '../../business_logic_layer/Authentication/Signin/bloc/sign_in_bloc.dart';
import '../../business_logic_layer/Provider/password_validator_provider.dart';

class AppBlocProvider {
  static get allBlocProvider => [
        BlocProvider(create: (_) => SignInBloc()),
        BlocProvider(create: (_) => SignUpBloc()),
        BlocProvider(create: (_) => EmailVerificationBloc()),
        BlocProvider(create: (_) => DashboardBloc()),
        BlocProvider(create: (_) => OnboardBloc()),
        BlocProvider(create: (_) => ProfileSettingsBloc()),
        BlocProvider(create: (_) => EditProfileBloc()),
        BlocProvider(create: (_) => ChangeProfileBloc()),
        BlocProvider(create: (_) => UserPreferenceBloc()),
        BlocProvider(create: (_) => SettingsBloc()),
        ChangeNotifierProvider(create: (_) => PasswordStrengthProvider()),
        ChangeNotifierProvider(create: (context) => ChangeThemeMode())
      ];
}
