import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lost_get/common/constants/colors.dart';
import 'package:lost_get/controller/Profile%20Settings/edit_profile_controller.dart';
import 'package:lost_get/models/user_profile.dart';
import 'package:lost_get/presentation_layer/widgets/button.dart';

import '../../../business_logic_layer/EditProfile/bloc/edit_profile_bloc.dart';
import '../../../common/constants/constant.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/edit_profile';

  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  EditProfileBloc editProfileBloc = EditProfileBloc();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  final FocusNode _phoneNumberFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _phoneNumberFocusNode.addListener(() {
      editProfileBloc.add(
          EditPhoneNumberFocusNodeClickedEvent(_phoneNumberFocusNode.hasFocus));
    });
  }

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        editProfileBloc.add(
            DateOfBirthOnChangedEvent(DateFormat("dd/MM/yyyy").format(value)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool phoneNumberFocused = _phoneNumberFocusNode.hasFocus;
    String? selectedDate;

    // Color borderColor = ;
    return BlocListener<EditProfileBloc, EditProfileState>(
        bloc: editProfileBloc,
        listener: (context, state) {
          if (state is BackButtonClickedState) {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          appBar: createAppBar(context, editProfileBloc),
          body: SingleChildScrollView(
            child: FutureBuilder(
                future: EditProfileController().getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserProfile userProfile = snapshot.data as UserProfile;
                      _fullNameController.text =
                          "${userProfile.firstName!} ${userProfile.lastName}";
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 14),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              createTitle(context, "Basic Information"),
                              SizedBox(
                                height: 6.h,
                              ),

                              Row(children: [
                                createEditImage(context),
                                SizedBox(
                                  width: 18.w,
                                ),
                                createBioFields(context, editProfileBloc,
                                    _fullNameController),
                              ]),

                              SizedBox(
                                height: 11.h,
                              ),
                              createProfileFields(
                                  context,
                                  'Bio',
                                  TextInputType.text,
                                  (bio) => editProfileBloc
                                      .add(BiographyOnChangedEvent(bio))),
                              SizedBox(
                                height: 4.h,
                              ),

                              // DROP DOWN
                              createMediumTitle("Gender"),
                              SizedBox(
                                height: 3.h,
                              ),
                              SizedBox(
                                  height: 20.h,
                                  child: DropDownTextField(
                                      initialValue: userProfile.dateOfBirth,
                                      dropDownItemCount: 3,
                                      listTextStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                      textStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                      searchDecoration: const InputDecoration(
                                          hintText: "Select Your Gender"),
                                      dropDownList: const [
                                        DropDownValueModel(
                                            name: 'Male', value: "Male"),
                                        DropDownValueModel(
                                            name: 'Female', value: "Female"),
                                        DropDownValueModel(
                                            name: 'Prefer Not To Say',
                                            value: "Prefer Not To Say"),
                                      ],
                                      textFieldDecoration:
                                          const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 7,
                                                      horizontal: 12),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)))),
                                      onChanged: (val) {})),
                              SizedBox(
                                height: 4.h,
                              ),
                              createMediumTitle("Date Of Birth"),
                              SizedBox(
                                height: 3.h,
                              ),
                              // Date of birth
                              BlocBuilder<EditProfileBloc, EditProfileState>(
                                bloc: editProfileBloc,
                                builder: (context, state) {
                                  return GestureDetector(
                                    onTap: () {
                                      _datePicker();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 12),
                                      alignment: Alignment.centerLeft,
                                      width: 375.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              width: 1)),
                                      child: Text(
                                          state.dateOfBirth.isEmpty
                                              ? "DD/MM/YYYY"
                                              : state.dateOfBirth,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    ),
                                  );
                                },
                              ),

                              SizedBox(
                                height: 11.h,
                              ),
                              createTitle(context, 'Contact Information'),
                              SizedBox(
                                height: 3.h,
                              ),
                              createProfileFields(context, 'Email Address',
                                  TextInputType.emailAddress, (email) {
                                editProfileBloc.add(EmailOnChangedEvent(email));
                              }),
                              SizedBox(
                                height: 3.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  createMediumTitle("Phone Number"),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  BlocBuilder<EditProfileBloc,
                                          EditProfileState>(
                                      bloc: editProfileBloc,
                                      builder: (context, state) {
                                        if (state
                                            is EditPhoneNumberFocusNodeClickedState) {
                                          phoneNumberFocused = state.hasFocus;
                                        }

                                        return Container(
                                          height: 20.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: phoneNumberFocused
                                                      ? AppColors.primaryColor
                                                      : Colors.black
                                                          .withOpacity(0.5),
                                                  width: phoneNumberFocused
                                                      ? 2
                                                      : 1)),
                                          child: Row(children: [
                                            Expanded(
                                                child: createDropdown(
                                                    context,
                                                    AppConstants.COUNTRY_CODE,
                                                    InputBorder.none,
                                                    "+92", (countryCode) {
                                              editProfileBloc.add(
                                                  CountryCodeOnChangedEvent(
                                                      countryCode));
                                            })),
                                            Expanded(
                                              flex: 3,
                                              child: TextField(
                                                onChanged: (phoneNumber) =>
                                                    editProfileBloc.add(
                                                        PhoneNumberOnChangedEvent(
                                                            phoneNumber)),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                                keyboardType:
                                                    TextInputType.phone,
                                                focusNode:
                                                    _phoneNumberFocusNode,
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 7,
                                                          horizontal: 2),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        );
                                      }),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  CreateButton(
                                      title: 'Save', handleButton: () {}),
                                ],
                              ),
                            ]),
                      );
                    } else {
                      const Text("Error");
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ));
  }
}

Widget createEditImage(context) {
  return Stack(children: [
    const CircleAvatar(
      backgroundColor: Colors.black,
      radius: 62,
      child: CircleAvatar(
        radius: 60,
        backgroundImage: NetworkImage(
            'https://scontent.fisb6-1.fna.fbcdn.net/v/t39.30808-6/333859605_874574363647996_2923649837563353558_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeFuAT4XujtBnD61yMJL3CsyHBxx5bXf9iEcHHHltd_2ITszPjDhvLOTGeof3lBdXXrOZQAmWCIPozfNFDAvfsqs&_nc_ohc=-uk4AjWjRgMAX9aXlkD&_nc_oc=AQk_yZoaG-j27I5dJRXKBd8DnE-okvgWC5v0nhBc66S4s4qMKPaQuZEda4J3hhy8mnw&_nc_ht=scontent.fisb6-1.fna&oh=00_AfD7U6lAX-MNLiv8q-7ov1U2B3stj4Yb_DidLBFaSwX_RQ&oe=64EAF973'),
      ),
    ),
    Positioned(
        bottom: 0,
        left: 80,
        child: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/edit_profile.svg',
            width: 13.w,
            height: 13.h,
          ),
          onPressed: () {},
        ))
  ]);
}

Widget createBioFields(context, EditProfileBloc editProfileBloc,
    TextEditingController textEditingController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Your Name",
        style: GoogleFonts.roboto(
          fontSize: 12.sp,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
      SizedBox(
        height: 3.h,
      ),
      SizedBox(
        width: 200.w,
        height: 20.h,
        child: TextField(
          controller: textEditingController,
          textAlign: TextAlign.start,
          onChanged: (fullName) {
            editProfileBloc.add(FullNameOnChangedEvent(fullName));
          },
          style: Theme.of(context).textTheme.bodySmall,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),

            // floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      )
    ],
  );
}

Widget createProfileFields(context, String title, TextInputType textInputType,
    Function handleOnChange) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 12.sp,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
      SizedBox(
        height: 3.h,
      ),
      SizedBox(
        height: 20.h,
        child: TextField(
          textAlign: TextAlign.start,
          onChanged: (value) {
            handleOnChange(value);
          },
          style: Theme.of(context).textTheme.bodySmall,
          keyboardType: textInputType,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),

            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),

            // floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ),
    ],
  );
}

Widget createTitle(context, String title) {
  return Text(
    title,
    style: Theme.of(context).textTheme.bodyMedium,
  );
}

Widget createMediumTitle(String title) {
  return Text(
    title,
    style: GoogleFonts.roboto(
      fontSize: 12.sp,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    ),
  );
}

PreferredSizeWidget? createAppBar(context, EditProfileBloc editProfileBloc) {
  return AppBar(
    leading: IconButton(
      onPressed: () => editProfileBloc.add(BackButtonClickedEvent()),
      icon: SvgPicture.asset(
        'assets/icons/arrow-left.svg',
        width: 24,
        height: 24,
      ),
    ),
    title: Text(
      "Profile",
      style: Theme.of(context).textTheme.bodyMedium,
    ),
    centerTitle: true,
    actions: [
      IconButton(
        icon: SvgPicture.asset(
          'assets/icons/three_dots.svg',
          width: 30,
          height: 30,
        ),
        onPressed: () {},
      )
    ],
  );
}

Widget createDropdown(context, List<String> lists, InputBorder inputBorder,
    String labelText, Function handleOnChange) {
  return TextField(
    style: Theme.of(context).textTheme.bodySmall,
    maxLength: 4,
    keyboardType: TextInputType.phone,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.only(bottom: 7, top: 7, left: 6),
      border: inputBorder,
      counterText: "",
      suffixIcon: DropdownButtonFormField(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          border: inputBorder,
          labelStyle: Theme.of(context).textTheme.bodySmall,
        ),
        onChanged: (value) {
          handleOnChange(value);
        },
        items: lists.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        }).toList(),
      ),
    ),
  );
}

// TextField(
//                 textAlign: TextAlign.start,
//                 onChanged: (value) {},
//                 style: Theme.of(context).textTheme.bodySmall,
//                 decoration: InputDecoration(
//                   labelText: "Select your gender",
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
//                   border: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(5))),
//                   suffixIcon: DropdownButtonFormField(
//                     decoration: const InputDecoration(
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 7, horizontal: 12),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(5))),
//                     ),
//                     onChanged: (value) {},
//                     items: AppConstants.GENDERS
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(
//                           value,
//                           style: Theme.of(context).textTheme.bodySmall,
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   // floatingLabelBehavior: FloatingLabelBehavior.never,
//                 ),
//               ),
//             ),


// createDropdown(
//                   context,
//                   AppConstants.GENDERS,
//                   const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(5),
//                     ),
//                   ),
//                   "Select A Gender",
//                   (gender) => editProfileBloc.add(
//                     GenderOnChangedEvent(gender),
//                   ),
//                 ),