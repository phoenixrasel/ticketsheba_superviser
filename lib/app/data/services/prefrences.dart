import 'package:get_storage/get_storage.dart';

class Pref {
  static final box = GetStorage();

  static var LOGIN_VALUE = 'login-value';
  static var PASS = 'login-pass';
  static var SESSION = 'login-session';
  static var IS_REMEMBER = 'is-remember';
  static var DEVICE_UNIQUE = 'device-unique';
  static var LAST_UPDATE_SHOW = 'last-update-show';
  static var IS_FACEBOOK_LIKE_SHOWN = 'facebook-like-shown';
  static var IS_GOOGLE_RATE_SHOWN = 'google-rate-shown';
  static var IS_FORCE_UPDATE = 'is-force-update';
  static var IS_PASS_UPDATE = 'is-pass-update';
  static var IS_NEW_APP_LOGIN = 'is-new-app-login';
  static var IS_FCM_TOKEN_SAVE = 'is-fcm-token-save';

  static void writeData({required String key, required dynamic value}) =>
      box.write(key, value);

  static dynamic readData({required String key}) => box.read(key);

  static void removeData({required String key}) => box.remove(key);
}
