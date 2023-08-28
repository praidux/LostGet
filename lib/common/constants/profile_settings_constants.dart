import 'package:lost_get/business_logic_layer/ProfileSettings/bloc/profile_settings_bloc.dart';

import '../../controller/Authentication/sign_in_controller.dart';

class ProfileSettingsConstants {
  final ProfileSettingsBloc profileSettingsBloc;

  ProfileSettingsConstants(this.profileSettingsBloc);
  List<Map<String, dynamic>> getProfileList() {
    return [
      {
        'imgUrl': 'assets/icons/view_my_report.svg',
        'title': 'View my reports',
        'subtitle': 'View your lost, found and recovered items',
        'handleFunction': () {},
      },
      {
        'imgUrl': 'assets/icons/support.svg',
        'title': 'Support and Help',
        'subtitle': 'Help centre and Legal Provisions',
        'handleFunction': () {},
      },
      {
        'imgUrl': 'assets/icons/setting.svg',
        'title': 'Settings',
        'subtitle': 'Privacy and manage your account',
        'handleFunction': () {},
      },
      {
        'imgUrl': 'assets/icons/share_feedback.svg',
        'title': 'Share Feedback',
        'subtitle': 'Share your valuable feedback with us',
        'handleFunction': () {},
      },
      {
        'imgUrl': 'assets/icons/logout.svg',
        'title': 'Log Out',
        'subtitle': 'Log out your account',
        'handleFunction': () {
          profileSettingsBloc.add(SignOutEvent());
        },
      }
    ];
  }
}
