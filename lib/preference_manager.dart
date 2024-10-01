import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static const String id = "id";
  static const String bearerToken = "bearerToken";
  static const String isOnboardingCompleted = 'isOnboardingCompleted';
  static const String mobileNo = 'mobileNo';
  static const String isFingerPrintEnabled = 'isFingerPrintEnabled';

  static setData(String key, dynamic value) async {
    getStorage().write(key, value);
  }

  static String? getString(String key) {
    return "${getStorage().read(key)}";
  }

  static bool? getBool(String key) {
    return getStorage().read(key);
  }

  static GetStorage getStorage() {
    return GetStorage();
  }

  static deleteData() async {
    getStorage().erase();
  }

  static setFingerPrintEnabled(bool value) async {
    setData(isFingerPrintEnabled, value);
  }

  static bool? isFingerPrintEnabledValue() {
    return getBool(isFingerPrintEnabled) ?? false;  // Default to false if not set
  }
}
