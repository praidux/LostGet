import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_get/business_logic_layer/ThemeMode/change_theme_mode.dart';
import 'package:lost_get/common/constants/colors.dart';
import 'package:lost_get/common/constants/constant.dart';
import 'package:lost_get/common/routes/app_routes.dart';
import 'package:lost_get/common/bloc_provider/bloc_provider.dart';
import 'package:lost_get/utils/theme.dart';
import 'package:provider/provider.dart';

import 'common/global.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 360),
        builder: ((context, child) {
          return MultiBlocProvider(
            providers: AppBlocProvider.allBlocProvider,
            child: ChangeNotifierProvider(
              create: (context) => ChangeThemeMode(),
              child: Consumer<ChangeThemeMode>(
                builder: (context, ChangeThemeMode changeThemeMode, state) {
                  // AppConstants.isDark = changeThemeMode.isDarkMode;
                  final bool isDyslexia = changeThemeMode.isDyslexia;
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'LostGet',
                    themeMode: changeThemeMode.currentTheme,
                    darkTheme: CustomTheme.lightTheme(isDyslexia),
                    theme: CustomTheme.darkTheme(isDyslexia),
                    onGenerateRoute: AppRouter().onGenerateRoute,
                  );
                },
              ),
            ),
          );
        }));
  }
}
