import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_get/common/constants/colors.dart';
import 'package:lost_get/common/routes/app_routes.dart';
import 'package:lost_get/common/bloc_provider/bloc_provider.dart';

import 'common/global.dart';
import 'firebase_options.dart';

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
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                fontFamily: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                ).fontFamily,
                useMaterial3: true,
                textTheme: TextTheme(
                    titleLarge: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: 28.sp,
                        color: AppColors.headingColor),
                    titleSmall: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: AppColors.headingColor),
                    bodySmall: GoogleFonts.montserrat(
                        fontSize: 13.sp, color: AppColors.placeHolderColor),
                    displaySmall: GoogleFonts.montserrat(
                        fontSize: 16.sp, color: AppColors.headingColor)),
              ),
              onGenerateRoute: AppRouter().onGenerateRoute,
            ),
          );
        }));
  }
}
