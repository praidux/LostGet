import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:lost_get/common/constants/colors.dart';
import 'package:lost_get/common/constants/constant.dart';
import 'package:lost_get/common/custom_icons/close_icons.dart';
import 'package:lost_get/controller/Profile%20Settings/edit_profile_controller.dart';
import 'package:lost_get/models/user_profile.dart';
import 'package:lost_get/presentation_layer/widgets/button.dart';
import 'package:lost_get/presentation_layer/widgets/toast.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import '../../../business_logic_layer/EditProfile/ChangeProfile/bloc/change_profile_bloc.dart';
import '../../../business_logic_layer/EditProfile/bloc/edit_profile_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_dialogs/material_dialogs.dart';

import '../../widgets/please_wait.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/edit_profile';

  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  EditProfileBloc editProfileBloc = EditProfileBloc();
  ChangeProfileBloc changeProfileBloc = ChangeProfileBloc();
  final SingleValueDropDownController _genderController =
      SingleValueDropDownController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  // final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;
  String? _uploadedImageUrl;
  String? _oldImageUrl;
  String? _completePhoneNumber;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _datePicker() async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        _dateOfBirthController.text = DateFormat("dd/MM/yyyy").format(value);
      }
    });
  }

  void _backPressedButton(context) {
    Dialogs.materialDialog(
        context: context,
        msg: "You have unsaved changes. Are you sure that you want to close?",
        msgStyle: GoogleFonts.roboto(
          fontSize: 12.sp,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        title: "Unsaved Changes",
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: 'No',
            color: Colors.grey,
            iconData: Icons.cancel,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            text: 'Yes',
            iconData: Icons.house,
            color: AppColors.primaryColor,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  OverlayEntry? overlayEntry;

  void showCustomLoadingDialog(BuildContext context) {
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned.fill(
          child: Container(
            color: Colors.transparent
                .withOpacity(0.7), // Make the overlay transparent
            child: const Center(
              child: PleaseWaitDialog(),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  void hideCustomLoadingDialog(BuildContext context) {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    editProfileBloc.add(EditProfileLoadEvent());
    return Scaffold(
      appBar: createAppBar(context, _backPressedButton),
      body: BlocConsumer<EditProfileBloc, EditProfileState>(
        bloc: editProfileBloc,
        listenWhen: (previous, current) => current is EditProfileActionState,
        listener: (context, state) {
          if (state is SaveButtonClickedSuccessState) {
            hideCustomLoadingDialog(context);
            createToast(description: "Profile Updated Successfully!");
            editProfileBloc.add(EditProfileLoadEvent());
          }
          if (state is SaveButtonClickedErrorState) {
            hideCustomLoadingDialog(context);
            createToast(description: state.description);
          }
          if (state is SaveButtonClickedLoadingState) {
            print("here");
            showCustomLoadingDialog(context);
          }
        },
        buildWhen: (previous, current) => current is! EditProfileActionState,
        builder: (context, state) {
          if (state is EditProfileLoadingState) {
            return const SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50,
            );
          }
          if (state is EditProfileErrorState) {
            return createToast(description: state.errorMsg);
          }

          if (state is EditProfileLoadedState) {
            setControllers(state.userProfile);

            return SingleChildScrollView(
                child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      createTitle(context, "Basic Information"),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(children: [
                        BlocBuilder<ChangeProfileBloc, ChangeProfileState>(
                          bloc: changeProfileBloc,
                          builder: (context, state) {
                            if (state is ChangeProfileLoadingState) {
                              Container(
                                width: 110.w,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                child: const SpinKitFadingCircle(
                                  color: AppColors.primaryColor,
                                  size: 50,
                                ),
                              );
                            }
                            if (state is ChangeProfileErrorState) {
                              createToast(description: state.errorMsg);
                            }
                            if (state is ChangeProfileLoadedState) {
                              print("i was here");
                              _pickedImage = state.pickedImage;

                              return Stack(children: [
                                Container(
                                    width: 110.w,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                      image: _pickedImage != null
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                File(_pickedImage!.path),
                                              ),
                                            )
                                          : const DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                "https://firebasestorage.googleapis.com/v0/b/lostget-faafe.appspot.com/o/defaultProfileImage.png?alt=media&token=15627898-29b2-47a1-b9cc-95c93a158cd1",
                                              )),
                                    )),
                                Positioned(
                                    bottom: 0,
                                    left: 80,
                                    child: IconButton(
                                      icon: SvgPicture.asset(
                                        'assets/icons/edit_profile.svg',
                                        width: 13.w,
                                        height: 13.h,
                                      ),
                                      onPressed: () {
                                        changeProfileBloc.add(ChangeProfile());
                                      },
                                    ))
                              ]);
                            }
                            print("2nd one called");
                            return Stack(children: [
                              Container(
                                  width: 110.w,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    image: _pickedImage != null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                              File(_pickedImage!.path),
                                            ),
                                          )
                                        : _uploadedImageUrl != null
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                    _uploadedImageUrl!),
                                                fit: BoxFit.cover)
                                            : const DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "https://firebasestorage.googleapis.com/v0/b/lostget-faafe.appspot.com/o/defaultProfileImage.png?alt=media&token=15627898-29b2-47a1-b9cc-95c93a158cd1",
                                                )),
                                  )),
                              Positioned(
                                  bottom: 0,
                                  left: 80,
                                  child: IconButton(
                                    icon: SvgPicture.asset(
                                      'assets/icons/edit_profile.svg',
                                      width: 13.w,
                                      height: 13.h,
                                    ),
                                    onPressed: () {
                                      changeProfileBloc.add(ChangeProfile());
                                    },
                                  ))
                            ]);
                          },
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        createBioFields(
                            context, editProfileBloc, _fullNameController),
                      ]),

                      SizedBox(
                        height: 11.h,
                      ),
                      createProfileFields(context, 'Bio', TextInputType.text,
                          _biographyController, (value) {}
                          // editProfileBloc
                          // .add(BiographyOnChangedEvent(bio))
                          ),
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
                              controller: _genderController,
                              initialValue: null,
                              dropDownItemCount: 3,
                              listTextStyle:
                                  Theme.of(context).textTheme.bodySmall,
                              textStyle: Theme.of(context).textTheme.bodySmall,
                              searchDecoration: const InputDecoration(
                                  hintText: "Select Your Gender"),
                              dropDownList: const [
                                DropDownValueModel(name: 'Male', value: "Male"),
                                DropDownValueModel(
                                    name: 'Female', value: "Female"),
                                DropDownValueModel(
                                    name: 'Prefer Not To Say',
                                    value: "Prefer Not To Say"),
                              ],
                              textFieldDecoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 12),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
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

                      TextField(
                        focusNode: AlwaysDisabledFocusNode(),
                        controller: _dateOfBirthController,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),

                          // floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        onTap: () {
                          _datePicker();
                        },
                      ),

                      SizedBox(
                        height: 11.h,
                      ),
                      createTitle(context, 'Contact Information'),
                      SizedBox(
                        height: 3.h,
                      ),
                      createProfileFields(
                          context,
                          'Email Address',
                          TextInputType.emailAddress,
                          _emailAddressController, (email) {
                        // editProfileBloc.add(EmailOnChangedEvent(email)
                        // );
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
                          IntlPhoneField(
                            controller: _phoneNumberController,
                            onChanged: (value) =>
                                _completePhoneNumber = value.completeNumber,
                            initialCountryCode: getPhoneIsoCountry(
                                state.userProfile.phoneNumber!),
                            dropdownTextStyle:
                                Theme.of(context).textTheme.bodySmall,
                            style: Theme.of(context).textTheme.bodySmall,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 12),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          CreateButton(
                              title: 'Save',
                              handleButton: () async {
                                print(_dateOfBirthController.text);
                                Map<String, dynamic> newProfileData = {
                                  "fullName": _fullNameController.text,
                                  "biography": _biographyController.text,
                                  "gender":
                                      _genderController.dropDownValue!.name,
                                  "dateOfBirth": _dateOfBirthController.text,
                                  "email": _emailAddressController.text,
                                };

                                if (_pickedImage != null) {
                                  newProfileData['imgUrl'] = _pickedImage;
                                  _oldImageUrl = state.userProfile.imgUrl;
                                  _pickedImage = null;
                                } else if (EditProfileController.oldImgUrl !=
                                    state.userProfile.imgUrl) {
                                  newProfileData['imgUrl'] = _pickedImage;
                                  _oldImageUrl = state.userProfile.imgUrl;
                                  _pickedImage = null;
                                }

                                if (_completePhoneNumber != null) {
                                  newProfileData['phoneNumber'] =
                                      _completePhoneNumber;
                                }

                                editProfileBloc.add(SaveButtonClickedEvent(
                                    context,
                                    newProfileData,
                                    state.userProfile,
                                    changeProfileBloc));

                                // var result = await EditProfileController()
                                //     .updateUserData(
                                //         newProfileData, state.userProfile);
                                // if (result == true) {
                                //   _pickedImage = null;
                                //   editProfileBloc
                                //       .add(SaveButtonClickedSuccessEvent());
                                //   changeProfileBloc
                                //       .add(ChangeProfileInitialEvent());
                                // } else if (result == false) {
                                //   createToast(
                                //       description:
                                //           "Please update the fields to make changes.");
                                // }
                              }),
                        ],
                      ),
                    ]),
              ),
            ));
          }
          return Container();
        },
      ),
    );
  }

  getPhoneIsoCountry(String phoneNumber) {
    PhoneNumber number =
        PhoneNumber.fromCompleteNumber(completeNumber: (phoneNumber));
    return number.countryISOCode;
  }

  getPhoneCodeCountry(String phoneNumber) {
    PhoneNumber number =
        PhoneNumber.fromCompleteNumber(completeNumber: (phoneNumber));
    return number.countryCode;
  }

  getPhoneNumber(String phoneNumber) {
    PhoneNumber number =
        PhoneNumber.fromCompleteNumber(completeNumber: (phoneNumber));
    return number.number;
  }

  void setControllers(UserProfile userProfile) {
    if (userProfile.fullName != "" && userProfile.dateOfBirth != null) {
      _fullNameController.text = userProfile.fullName!;
    } else {
      _fullNameController.text = "";
    }

    if (userProfile.gender != "" && userProfile.gender != null) {
      _genderController.dropDownValue = DropDownValueModel(
          name: userProfile.gender!, value: userProfile.gender!);
    }

    if (userProfile.biography != "" && userProfile.biography != null) {
      _biographyController.text = userProfile.biography!;
    } else {
      _biographyController.text = '';
    }

    if (userProfile.email != "" && userProfile.email != null) {
      _emailAddressController.text = userProfile.email!;
    } else {
      _emailAddressController.text = '';
    }

    _emailAddressController.text =
        userProfile.email != null ? userProfile.email! : "";

    if (userProfile.dateOfBirth != "" && userProfile.dateOfBirth != null) {
      _dateOfBirthController.text = userProfile.dateOfBirth!;
    } else {
      _dateOfBirthController.text = "DD/MM/YYYY";
    }

    if (userProfile.phoneNumber != "" && userProfile.phoneNumber != null) {
      _phoneNumberController.text = getPhoneNumber(userProfile.phoneNumber!);
    } else {
      _phoneNumberController.text = '';
    }

    if (userProfile.imgUrl != "" && userProfile.imgUrl != null) {
      _uploadedImageUrl = userProfile.imgUrl;
    }
  }

  Widget createEditImage(context, Function handleImagePicker) {
    return Stack(children: [
      _pickedImage == null
          ? Text('No Image Ex')
          : Image.file(File(_pickedImage!.path)),
      Positioned(
          bottom: 0,
          left: 80,
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/edit_profile.svg',
              width: 13.w,
              height: 13.h,
            ),
            onPressed: () {
              handleImagePicker();
            },
          ))
    ]);
  }
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
            // editProfileBloc.add(FullNameOnChangedEvent(fullName));
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
    TextEditingController textEditingController, Function handleOnChange) {
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
          controller: textEditingController,
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

PreferredSizeWidget? createAppBar(context, Function backPressedButton) {
  return AppBar(
    leading: IconButton(
      onPressed: () => backPressedButton(context),
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
