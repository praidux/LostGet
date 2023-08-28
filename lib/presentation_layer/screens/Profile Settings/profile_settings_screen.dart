import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_get/presentation_layer/screens/Profile%20Settings/edit_profile.dart';
import 'package:lost_get/presentation_layer/widgets/profile_settings_widget.dart';

import '../../../business_logic_layer/ProfileSettings/bloc/profile_settings_bloc.dart';
import '../../../common/constants/profile_settings_constants.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  ProfileSettingsBloc profileSettingsBloc = ProfileSettingsBloc();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> profileList =
        ProfileSettingsConstants(profileSettingsBloc).getProfileList();
    return BlocListener<ProfileSettingsBloc, ProfileSettingsState>(
      bloc: profileSettingsBloc,
      listener: (context, state) {
        if (state is EditProfileButtonClickedState) {
          Navigator.pushNamed(context, EditProfile.routeName);
        }
      },
      child: SafeArea(
          child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(left: 18, right: 18, top: 14),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 62,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://scontent.fisb6-1.fna.fbcdn.net/v/t39.30808-6/333859605_874574363647996_2923649837563353558_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeFuAT4XujtBnD61yMJL3CsyHBxx5bXf9iEcHHHltd_2ITszPjDhvLOTGeof3lBdXXrOZQAmWCIPozfNFDAvfsqs&_nc_ohc=-uk4AjWjRgMAX9aXlkD&_nc_oc=AQk_yZoaG-j27I5dJRXKBd8DnE-okvgWC5v0nhBc66S4s4qMKPaQuZEda4J3hhy8mnw&_nc_ht=scontent.fisb6-1.fna&oh=00_AfD7U6lAX-MNLiv8q-7ov1U2B3stj4Yb_DidLBFaSwX_RQ&oe=64EAF973'),
                    ),
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Syed Danish",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      InkWell(
                        onTap: () => profileSettingsBloc
                            .add(EditProfileButtonClickedEvent()),
                        child: Text("View and edit profile",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            )),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Column(
                children: profileList
                    .map((e) => createListTile(
                        e['title'] as String,
                        e['subtitle'] as String,
                        e['imgUrl'] as String,
                        e['handleFunction'] as Function))
                    .toList(),
              )
            ],
          ),
        ),
      )),
    );
  }
}
