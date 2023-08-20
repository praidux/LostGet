import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lost_get/business_logic_layer/Authentication/Signup/bloc/sign_up_bloc.dart';

import '../business_logic_layer/Authentication/Signin/bloc/sign_in_bloc.dart';

class AppBlocProvider {
  static get allBlocProvider => [
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => SignUpBloc()),
      ];
}
