// models/otp_verification_model.dart
class OtpVerificationModel {
  final String phone;
  final String otp;

  OtpVerificationModel({required this.phone, required this.otp});

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'otp': otp,
    };
  }
}
// otp_model.dart

class OtpResponse {
  final String message;
  final String? error;

  OtpResponse({required this.message, this.error});

  // Factory constructor to create an instance from JSON
  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      message: json['message'] ?? '',
      error: json['error'],
    );
  }
}
//reset_password model
class ResetPasswordModel {
  final String phone;
  final String otp;
  final String newPassword;
  final String confirmPassword;

  ResetPasswordModel({
    required this.phone,
    required this.otp,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'otp': otp,
      'new_password': newPassword,
      'new_password_confirmation': confirmPassword,
    };
  }
}
