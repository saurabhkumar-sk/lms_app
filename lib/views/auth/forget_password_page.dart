import 'package:flutter/material.dart';
import 'package:gyanavi_academy/views/auth/password_reset_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/components/app_back_button.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/routes/app_routes.dart';
import '../../repository/reset.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _phoneController = TextEditingController();
  final OtpRepository _otpRepository =
  OtpRepository(); // Initialize the repository
  bool _isLoading = false;

  // Method to handle sending the OTP
  Future<void> _sendOtp() async {
    setState(() {
      _isLoading = true;
    });

    // Call the resendOtp method from the repository with the phone number
    final response =
    await _otpRepository.resendOtp(_phoneController.text.trim());

    setState(() {
      _isLoading = false;
    });

    if (response.error != null) {
      // Show error message if there's an error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.error!)),
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('phoneNumber', _phoneController.text.trim());

      // Navigate to the password reset screen on success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message)),
      );
      // Navigator.pushNamed(
      //   context,
      //   AppRoutes.passwordReset,
      //   arguments: _phoneController.text,
      // );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Forget Password'),
        backgroundColor: AppColors.scaffoldBackground,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(AppDefaults.margin),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding,
                  vertical: AppDefaults.padding * 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppDefaults.borderRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Reset your password',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppDefaults.padding),
                    const Text(
                      'Please enter your number. We will send a code\nto your phone to reset your password.',
                    ),
                    const SizedBox(height: AppDefaults.padding * 3),
                    const Text("Phone Number"),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _phoneController,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your phone number',
                      ),
                    ),
                    const SizedBox(height: AppDefaults.padding),
                    const SizedBox(height: AppDefaults.padding),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _isLoading
                              ? null
                              : _sendOtp().then((val) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PasswordResetPage(
                                    phoneNumber: _phoneController.text,
                                  ),
                                ));
                          });
                        }, // Disable button if loading
                        child: _isLoading
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : const Text('Send me code'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
