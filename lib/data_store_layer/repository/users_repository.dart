import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lost_get/data_store_layer/repository/users_base_repository.dart';
import 'package:lost_get/presentation_layer/widgets/toast.dart';
import '../../models/user_profile.dart';

class UserRepository extends BaseUsersRepository {
  final FirebaseFirestore _firebaseFirestore;
  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<UserProfile> getUserDetails(String email) async {
    late final userData;
    try {
      final snapshot = await _firebaseFirestore
          .collection('users')
          .where("email", isEqualTo: email)
          .get();

      userData = snapshot.docs.map((e) => UserProfile.fromSnapshot(e)).single;
    } catch (e) {
      createToast(description: "Error Occurred");
    }
    return userData;
  }

  Future<void> createUserProfile(String uid, UserProfile user) async {
    final userProfileRef = _firebaseFirestore.collection('users');
    await userProfileRef.doc(uid).set(user.toMap());
  }

  Future<void> updateUserData(String uid, Map<String, dynamic> userData) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(userData);
  }

  Future<String> uploadProfileImage(XFile? image) async {
    File imageFile = File(image!.path);
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('profileImages/${DateTime.now()}.jpg');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    // Get the download URL of the uploaded image
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    print("Url is $downloadUrl");
    return downloadUrl;
  }
}
