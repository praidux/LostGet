import 'package:lost_get/common/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool getDeviceFirstOpen() {
    return _prefs.getBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME) ?? false;
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getTokenId() {
    return _prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY);
  }

  bool removeTokenId() {
    // ignore: unrelated_type_equality_checks
    return _prefs.remove(AppConstants.STORAGE_USER_TOKEN_KEY) == true
        ? true
        : false;
  }
}
