import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gyanavi_academy/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/signup.dart';
import '../response_structure/response_structure.dart';

class SignupRepository {

  /// Sign Up API -----------------
  static Future<ApiResponse<ResponseSignUp>> signUp(
      String name, String email, String phone, String password, String password_confirmation) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await http.post(
        Uri.parse("$mainUrl/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
          "password_confirmation":password_confirmation
        }),
      );
      EasyLoading.dismiss();

      if (response.statusCode == 200) {
        var obj = responseSignUpFromJson(response.body);

        // Store token, email, id, and name in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', obj.data?.token ?? "");
        await prefs.setString('email', obj.data?.user?.email ?? "");
        await prefs.setString('name', obj.data?.user?.name ?? "");
        await prefs.setString('phone', obj.data?.user?.phone ?? "");
        await prefs.setInt('userId', obj.data?.user?.id ?? 0);

        return ApiResponse(
          httpCode: response.statusCode,
          success: obj.result ?? false,
          message: obj.message ?? "Sign up successful",
          data: obj,
        );
      } else {
        var obj = responseSignUpFromJson(response.body);
        return ApiResponse(
          httpCode: response.statusCode,
          success: obj.result ?? false,
          message: obj.message ?? "Sign up failed",
          data: obj,
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(e);
      }
      return ApiResponse(
          httpCode: -1, message: "Connection error: ${e.toString()}");
    }
  }
}
