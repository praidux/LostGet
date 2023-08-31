import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lost_get/business_logic_layer/Dashboard/bloc/dashboard_bloc.dart';
import 'package:lost_get/business_logic_layer/ThemeMode/change_theme_mode.dart';
import 'package:provider/provider.dart';

import '../../common/constants/colors.dart';

class NavBar extends StatelessWidget {
  final DashboardBloc dashboardBloc;
  const NavBar({super.key, required this.dashboardBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
        ),
      ]),
      child: Consumer(
        builder: (context, ChangeThemeMode changeThemeMode, child) {
          final bool isDyslexia = changeThemeMode.isDyslexia;
          ColorFilter? colorFilter = changeThemeMode.isDarkMode()
              ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
              : null;
          return BottomNavigationBar(
            onTap: (value) {
              dashboardBloc.add(TriggerAppEvent(value));
            },
            currentIndex: dashboardBloc.state.index,
            unselectedFontSize: 13,
            selectedFontSize: 13,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/home_inactive.svg',
                    colorFilter: colorFilter),
                activeIcon: SvgPicture.asset('assets/icons/home_active.svg',
                    colorFilter: colorFilter),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/chat_inactive.svg',
                    colorFilter: colorFilter),
                activeIcon: SvgPicture.asset('assets/icons/chat_active.svg',
                    colorFilter: colorFilter),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/add_report_inactive.svg',
                      colorFilter: colorFilter),
                  activeIcon: SvgPicture.asset(
                    changeThemeMode.isDarkMode()
                        ? 'assets/icons/dark_add_report_active.svg'
                        : 'assets/icons/add_report_active.svg',
                  ),
                  label: "Report"),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/my_reports_inactive.svg',
                    colorFilter: colorFilter),
                activeIcon: SvgPicture.asset(
                  changeThemeMode.isDarkMode()
                      ? 'assets/icons/dark_my_reports_active.svg'
                      : 'assets/icons/my_reports_active.svg',
                ),
                label: 'My Reports',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    'assets/icons/profile_settings_inactive.svg',
                    colorFilter: colorFilter),
                activeIcon: SvgPicture.asset(
                    'assets/icons/profile_settings_active.svg',
                    colorFilter: colorFilter),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
