import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lost_get/data_store_layer/repository/users_base_repository.dart';
import '../../models/user_profile.dart';

class UserRepository extends BaseUsersRepository {
  final FirebaseFirestore _firebaseFirestore;
  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<UserProfile> getUserDetails(String email) async {
    final snapshot = await _firebaseFirestore
        .collection('users')
        .where("email", isEqualTo: email)
        .get();

    final userData =
        snapshot.docs.map((e) => UserProfile.fromSnapshot(e)).single;

    return userData;
  }

  Future<void> createUserProfile(String uid, UserProfile user) async {
    final userProfileRef = _firebaseFirestore.collection('users');
    await userProfileRef.doc(uid).set(user.toMap());
  }
}
