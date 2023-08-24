import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_get/common/constants/colors.dart';
import 'package:lost_get/common/routes/app_routes.dart';
import 'package:lost_get/common/bloc_provider/bloc_provider.dart';

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
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'LostGet',
              theme: ThemeData(
                // primaryColor: AppColors.primaryColor,
                colorSchemeSeed: AppColors.primaryColor,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                fontFamily: GoogleFonts.roboto(
                  fontSize: 14.sp,
                ).fontFamily,
                useMaterial3: true,
                textTheme: TextTheme(
                    titleLarge: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontSize: 28.sp,
                        color: AppColors.headingColor),
                    titleSmall: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: AppColors.headingColor),
                    bodySmall: GoogleFonts.roboto(
                        fontSize: 12.sp, color: Colors.black),
                    displaySmall: GoogleFonts.roboto(
                        fontSize: 16.sp, color: AppColors.headingColor),
                    bodyMedium: GoogleFonts.roboto(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700)),
              ),
              onGenerateRoute: AppRouter().onGenerateRoute,
            ),
          );
        }));
  }
}
