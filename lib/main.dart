import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_get/constants/colors.dart';
import 'package:lost_get/routes/app_routes.dart';

void main() {
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
          return MaterialApp(
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
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
              useMaterial3: true,
              canvasColor: Colors.white,
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
                    fontSize: 14, color: AppColors.placeHolderColor),
              ),
            ),
            onGenerateRoute: AppRouter().onGenerateRoute,
          );
        }));
  }
}
