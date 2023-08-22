import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lost_get/business_logic_layer/Dashboard/bloc/dashboard_bloc.dart';

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
      child: BottomNavigationBar(
        onTap: (value) {
          dashboardBloc.add(TriggerAppEvent(value));
        },
        elevation: 0,
        currentIndex: dashboardBloc.state.index,
        selectedLabelStyle: const TextStyle(
          fontSize: 13,
          color: AppColors.textColor,
          fontWeight: FontWeight.w600,
        ),
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 13,
        selectedFontSize: 13,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home_inactive.svg',
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/home_active.svg',
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/chat_inactive.svg'),
            activeIcon: SvgPicture.asset('assets/icons/chat_active.svg'),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/add_report_inactive.svg'),
              activeIcon:
                  SvgPicture.asset('assets/icons/add_report_active.svg'),
              label: "Report"),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/my_reports_inactive.svg'),
            activeIcon: SvgPicture.asset('assets/icons/my_reports_active.svg'),
            label: 'My Reports',
          ),
          BottomNavigationBarItem(
            icon:
                SvgPicture.asset('assets/icons/profile_settings_inactive.svg'),
            activeIcon:
                SvgPicture.asset('assets/icons/profile_settings_active.svg'),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
