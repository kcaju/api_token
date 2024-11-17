import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_test/model/login_model.dart';

class LoginController with ChangeNotifier {
  bool isLoading = false;
  Future<bool> toLogin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    //setup url

    final url = Uri.parse("https://freeapi.luminartechnohub.com/login");
    isLoading = true;
    notifyListeners();
    try {
      //call http

      final response =
          await http.post(url, body: {"email": email, "password": password});
      //check statuscode
      if (response.statusCode == 200) {
        //convert data
        LoginResModel loginModel = loginResModelFromJson(response.body);
        //check access available or not
        if (loginModel.access != null && loginModel.access!.isNotEmpty) {
          //token store
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("access", loginModel.access.toString());
          await prefs.setString("refresh", loginModel.refresh.toString());
        }
        isLoading = false;
        notifyListeners();
        return true; //after login
      } else {
        var decodedData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text(decodedData['detail'])));
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
    return false; //all other cases
  }
}
