import 'package:firebase_auth/firebase_auth.dart';

import '../../data_store_layer/repository/users_repository.dart';

class EditProfileController {
  final UserRepository _userRepo = UserRepository();

  getUserData() {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    }
  }
}
