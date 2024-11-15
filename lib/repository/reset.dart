// otp_repository.dart

import 'dart:convert';
import 'package:gyanavi_academy/constants.dart';
import 'package:http/http.dart' as http;

import '../models/verification.dart';


class OtpRepository {


  // Function to call the resend OTP endpoint
  Future<OtpResponse> resendOtp(String phone) async {
    final url = Uri.parse('$mainUrl/resend-otp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );

      // Check the response status code
      if (response.statusCode == 200) {
        return OtpResponse.fromJson(jsonDecode(response.body));
      } else {
        // Error response with message from the server
        final errorData = jsonDecode(response.body);
        return OtpResponse(
          message: '',
          error: errorData['error'] ?? 'Failed to resend OTP',
        );
      }
    } catch (e) {
      // Return error if there's an exception
      return OtpResponse(
        message: '',
        error: 'An error occurred. Please try again later.',
      );
    }
  }
}
