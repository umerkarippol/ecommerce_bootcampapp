// import 'package:shared_preferences/shared_preferences.dart';

// class Helper {
//   static String valueSharedPreferences = '';

// // Write DATA
//   static Future<bool> saveUserData(value) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return await sharedPreferences.setInt(valueSharedPreferences, value);
//   }

//   static Future saveLoggedIn(value) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return await sharedPreferences.setBool(valueSharedPreferences, value);
//   }

//   static Future getLoggedIn() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return sharedPreferences.getBool(valueSharedPreferences);
//   }

//   static Future saveUsername(value) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return await sharedPreferences.setString(valueSharedPreferences, value);
//   }

//   static Future getUsername() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return sharedPreferences.getString(valueSharedPreferences);
//   }

// // Read Data
//   static Future getUserData() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return sharedPreferences.getInt(valueSharedPreferences);
//   }
// }
