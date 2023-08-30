import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_get/business_logic_layer/ThemeMode/change_theme_mode.dart';
import 'package:lost_get/common/constants/colors.dart';
import 'package:lost_get/common/constants/constant.dart';
import 'package:lost_get/common/routes/app_routes.dart';
import 'package:lost_get/common/bloc_provider/bloc_provider.dart';
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
                  AppConstants.isDark = changeThemeMode.isDarkMode;
                  final bool isDyslexia = changeThemeMode.isDyslexia;
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'LostGet',
                    themeMode: changeThemeMode.currentTheme,
                    darkTheme: ThemeData(
                      scaffoldBackgroundColor: AppColors.darkPrimaryColor,
                      colorSchemeSeed: AppColors.primaryColor,
                      appBarTheme: const AppBarTheme(
                        backgroundColor: AppColors.darkPrimaryColor,
                        elevation: 0,
                      ),
                      bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        backgroundColor: AppColors.darkPrimaryColor,
                        elevation: 0,
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor: Colors.white,
                        selectedLabelStyle: GoogleFonts.roboto(
                          fontSize: 13,
                          fontWeight:
                              isDyslexia ? FontWeight.w900 : FontWeight.w600,
                        ),
                        unselectedItemColor: Colors.white,
                        unselectedLabelStyle: GoogleFonts.roboto(
                          fontSize: 13,
                          fontWeight:
                              isDyslexia ? FontWeight.w900 : FontWeight.normal,
                        ),
                      ),
                      fontFamily: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.normal)
                          .fontFamily,
                      useMaterial3: true,
                      textTheme: TextTheme(
                          titleLarge: GoogleFonts.roboto(
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.w700,
                              fontSize: 28.sp,
                              color: Colors.white),
                          titleSmall: GoogleFonts.roboto(
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.w600,
                              fontSize: 14.sp,
                              color: Colors.white),
                          bodySmall: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.normal),
                          displayMedium: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.normal),
                          bodyMedium: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.w700),
                          // place holder color for or continue with
                          headlineSmall: GoogleFonts.roboto(
                              fontSize: 13.sp,
                              color: Colors.white,
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.normal),
                          displaySmall: GoogleFonts.roboto(
                              fontSize: 13.sp,
                              color: Colors.white,
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.normal)

                          // this textTheme is for forgotPassword and rich Texts
                          ),
                    ),
                    theme: ThemeData(
                      bottomNavigationBarTheme: BottomNavigationBarThemeData(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          type: BottomNavigationBarType.fixed,
                          selectedItemColor: Colors.black,
                          selectedLabelStyle: GoogleFonts.roboto(
                            fontSize: 13,
                            fontWeight:
                                isDyslexia ? FontWeight.w900 : FontWeight.w600,
                          ),
                          unselectedItemColor: Colors.black,
                          unselectedLabelStyle: GoogleFonts.roboto(
                            fontSize: 13,
                            fontWeight: isDyslexia
                                ? FontWeight.w900
                                : FontWeight.normal,
                          )),
                      // primaryColor: AppColors.primaryColor,
                      colorSchemeSeed: AppColors.primaryColor,
                      scaffoldBackgroundColor: Colors.white,
                      appBarTheme: const AppBarTheme(
                        backgroundColor: Colors.white,
                        elevation: 0,
                      ),
                      fontFamily: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.normal)
                          .fontFamily,
                      useMaterial3: true,
                      textTheme: TextTheme(
                          titleLarge: GoogleFonts.roboto(
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.w700,
                              fontSize: 28.sp,
                              color: AppColors.headingColor),
                          titleSmall: GoogleFonts.roboto(
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.w600,
                              fontSize: 14.sp,
                              color: Colors.black),
                          bodySmall: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.normal),
                          bodyMedium: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.w700),
                          // place holder color for or continue with
                          headlineSmall: GoogleFonts.roboto(
                              fontSize: 13.sp,
                              color: AppColors.placeHolderColor,
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.w600),
                          displaySmall: GoogleFonts.roboto(
                              fontSize: 13.sp,
                              color: Colors.black,
                              fontWeight: isDyslexia
                                  ? FontWeight.w900
                                  : FontWeight.normal)
                          // this textTheme is for forgotPassword and rich Texts
                          ),
                    ),
                    onGenerateRoute: AppRouter().onGenerateRoute,
                  );
                },
              ),
            ),
          );
        }));
  }
}
