import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../data_store_layer/repository/users_repository.dart';
import '../../../../models/user_profile.dart';

class ChangePhoneNumberController {
  final UserRepository _userRepo = UserRepository();
  final _auth = FirebaseAuth.instance;
  static String verificationCode = "";

  getPhoneNumber(String phoneNumber) {
    PhoneNumber number =
        PhoneNumber.fromCompleteNumber(completeNumber: (phoneNumber));
    return number.number;
  }

  getUserPhoneNumber() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      if (uid != null) {
        UserProfile? userProfile = await _userRepo.getUserDetails(uid);
        String? phoneNumber = userProfile!.phoneNumber;
        return phoneNumber;
      }
    } catch (e) {}
  }

  getPhoneIsoCountry(String phoneNumber) {
    PhoneNumber number =
        PhoneNumber.fromCompleteNumber(completeNumber: (phoneNumber));
    print("Helloi  ${number.countryISOCode}");

    return number.countryISOCode;
  }

  updatePhoneNumber(String newPhoneNumber, String oldPhoneNumber) {
    Map<String, dynamic> newMap = {};
    if (oldPhoneNumber != newPhoneNumber && newPhoneNumber != null) {
      print("1");
      newMap['phoneNumber'] = newPhoneNumber;
    }
  }

  Future<void> phoneNumberVerification(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+923175463630",
      verificationCompleted: (phoneAuthCredential) async {
        print("HJere");
        await _auth.signInWithCredential(phoneAuthCredential);
        storePhoneNumberInFirestore();
      },
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) async {
        verificationCode = verificationId;

        // verifyOtp(verificationId);
      },
      codeAutoRetrievalTimeout: ((verificationId) {
        // this.verificationId = verificationId;
      }),
    );
  }

  Future<bool> verifyOtp(String otp) async {
    late final UserCredential? credentials;
    try {
      print("Credentials ${_auth.currentUser!.displayName}");
      print("OTP IS $otp");
      print("Verification Id 2 ${verificationCode}");

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationCode, smsCode: "123456");
      final currentUser = _auth.currentUser;
      await currentUser!.linkWithCredential(credential).then((value) {
        storePhoneNumberInFirestore();
      });

      await _auth.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<bool> storePhoneNumberInFirestore() async {
    try {
      User currentUser = _auth.currentUser!;

      if (currentUser.phoneNumber != null) {
        await currentUser.unlink('phone');
        return true;
      } else {
        return false;
      }
    } catch (e) {}
    return false;
  }
}
