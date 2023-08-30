import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_get/business_logic_layer/ThemeMode/change_theme_mode.dart';
import 'package:provider/provider.dart';

class UserPreferenceScreen extends StatefulWidget {
  static const routeName = '/user_preference';
  const UserPreferenceScreen({super.key});

  @override
  State<UserPreferenceScreen> createState() => _UserPreferenceScreenState();
}

class _UserPreferenceScreenState extends State<UserPreferenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ChangeThemeMode changeThemeMode, child) => Scaffold(
        appBar: AppBar(
            title: Text("User Preference",
                style: Theme.of(context).textTheme.bodyMedium),
            iconTheme: IconThemeData(
                color:
                    changeThemeMode.isDarkMode ? Colors.white : Colors.black),
            centerTitle: true),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  hoverColor: null,
                  title: Text(
                    "Dark Mode",
                    style: GoogleFonts.roboto(
                      color: changeThemeMode.isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14.sp,
                      fontWeight: changeThemeMode.isDyslexia
                          ? FontWeight.bold
                          : FontWeight.w700,
                    ),
                  ),
                  value: changeThemeMode.isDarkMode,
                  onChanged: (value) {
                    changeThemeMode.toggleTheme(value);
                  },
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.2),
                  height: 1,
                  thickness: 1,
                ),
                SwitchListTile(
                  hoverColor: null,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  title: Text(
                    "Dyslexia Friendly",
                    style: GoogleFonts.roboto(
                      color: changeThemeMode.isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14.sp,
                      fontWeight: changeThemeMode.isDyslexia
                          ? FontWeight.bold
                          : FontWeight.w700,
                    ),
                  ),
                  value: changeThemeMode.isDyslexia,
                  onChanged: (value) {
                    changeThemeMode.toggleDyslexia(value);
                  },
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.2),
                  height: 1,
                  thickness: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
