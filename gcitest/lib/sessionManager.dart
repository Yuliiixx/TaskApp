// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:gcitest/user_model.dart';

// class SessionManager {
//   static const String _loggedInKey = 'loggedIn';
//   static const String _userIdKey = 'userId';

//   static SharedPreferences? _prefs;

//   static Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   static Future<void> setLoggedIn(bool loggedIn) async {
//     if (_prefs == null) await init();
//     await _prefs!.setBool(_loggedInKey, loggedIn);
//   }

//   static bool isLoggedIn() {
//     if (_prefs == null) return false;
//     return _prefs!.getBool(_loggedInKey) ?? false;
//   }

//   static Future<void> setUserId(int userId) async {
//     if (_prefs == null) await init();
//     await _prefs!.setInt(_userIdKey, userId);
//   }

//   static int? getUserId() {
//     if (_prefs == null) return null;
//     return _prefs!.getInt(_userIdKey);
//   }

//   static Future<void> clearSession() async {
//     if (_prefs == null) await init();
//     await _prefs!.clear();
//   }

//   static Future<void> setUserSession(User user) async {
//     await setUserId(user.id);
//     await setLoggedIn(true);
//   }

//   static Future<void> clearUserSession() async {
//     await setUserId(0); // Assuming 0 is not a valid user ID
//     await setLoggedIn(false);
//   }
// }
