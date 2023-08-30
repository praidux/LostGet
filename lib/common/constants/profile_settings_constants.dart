import 'package:lost_get/business_logic_layer/ProfileSettings/Settings/bloc/settings_bloc.dart';
import 'package:lost_get/business_logic_layer/ProfileSettings/bloc/profile_settings_bloc.dart';
import 'package:lost_get/common/constants/constant.dart';

class ProfileSettingsConstants {
  final ProfileSettingsBloc? profileSettingsBloc;
  final SettingsBloc? settingsBloc;

  ProfileSettingsConstants({this.profileSettingsBloc, this.settingsBloc});
  List<Map<String, dynamic>> getProfileList() {
    return [
      {
        'imgUrl': AppConstants.isDark
            ? 'assets/icons/dark_view_my_reports.svg'
            : 'assets/icons/view_my_report.svg',
        'title': 'View my reports',
        'subtitle': 'View your lost, found and recovered items',
        'handleFunction': () {},
      },
      {
        'imgUrl': AppConstants.isDark
            ? 'assets/icons/dark_support.svg'
            : 'assets/icons/support.svg',
        'title': 'Support and Help',
        'subtitle': 'Help centre and Legal Provisions',
        'handleFunction': () {},
      },
      {
        'imgUrl': AppConstants.isDark
            ? 'assets/icons/dark_setting.svg'
            : 'assets/icons/setting.svg',
        'title': 'Settings',
        'subtitle': 'Privacy and manage your account',
        'handleFunction': () {
          profileSettingsBloc!.add(SettingsButtonClickedEvent());
        },
      },
      {
        'imgUrl': AppConstants.isDark
            ? 'assets/icons/dark_share_feedback.svg'
            : 'assets/icons/share_feedback.svg',
        'title': 'Share Feedback',
        'subtitle': 'Share your valuable feedback with us',
        'handleFunction': () {},
      },
      {
        'imgUrl': AppConstants.isDark
            ? 'assets/icons/dark_logout.svg'
            : 'assets/icons/logout.svg',
        'title': 'Log Out',
        'subtitle': 'Log out your account',
        'handleFunction': () {
          profileSettingsBloc!.add(SignOutAlertDialogEvent());
        },
      }
    ];
  }

  List<Map<String, dynamic>> getSettingsList() {
    return [
      {
        'title': "Manage Account",
        'subtitle': "Manage your personal details.",
        'handleFunction': () {}
      },
      {
        'title': "User Preference",
        'subtitle': "Customize application appearance",
        'handleFunction': () {
          settingsBloc!.add(UserPreferenceButtonClickedEvent());
        }
      },
      {
        'title': "Notifications",
        'subtitle': "Manage push & recommendation notifications",
        'handleFunction': () {}
      },
      {
        'title': "Privacy Policy",
        'subtitle': "Look into our app privacy policy",
        'handleFunction': () {}
      },
    ];
  }
}
