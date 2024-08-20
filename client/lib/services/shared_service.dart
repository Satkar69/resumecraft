import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:resumecraft/models/login/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static const String KEY_LOGIN_RESPONSE = "login_response";

  static Future<bool> setLoginResponse(LoginResponseModel loginResponse) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(
        KEY_LOGIN_RESPONSE, json.encode(loginResponse.toJson()));
  }

  static Future<LoginResponseModel?> getLoginResponse() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(KEY_LOGIN_RESPONSE);
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return LoginResponseModel.fromJson(jsonMap);
    }
    return null;
  }

  static Future<bool> isLoggedIn() async {
    final loginResponse = await getLoginResponse();
    return loginResponse?.token != null;
  }

  static Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(KEY_LOGIN_RESPONSE);
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
