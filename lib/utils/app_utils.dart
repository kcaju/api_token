import 'package:shared_preferences/shared_preferences.dart';

class AppUtils {
  static Future<String> getStoredAccessToken() async {
    //sharedpref object
    SharedPreferences preferences = await SharedPreferences.getInstance();

    //get stored access token
    String storedToken = preferences.getString("access") ?? "";
    return storedToken;
  }

  // static Future<String> getStoredRefreshToken() async {
  //   //sharedpref object
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   //get stored access token
  //   String storedToken = preferences.getString("refresh") ?? "";
  //   return storedToken;
  // }
}
