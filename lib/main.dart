import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_get/business_logic_layer/Authentication/Signin/bloc/sign_in_bloc.dart';
import 'package:lost_get/constants/colors.dart';
import 'package:lost_get/routes/app_routes.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
            providers: [
              BlocProvider(create: ((context) => SignInBloc())),
            ],
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
                      fontSize: 14.sp, color: AppColors.placeHolderColor),
                ),
              ),
              onGenerateRoute: AppRouter().onGenerateRoute,
            ),
          );
        }));
  }
}
