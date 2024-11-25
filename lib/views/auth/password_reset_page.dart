// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/components/app_back_button.dart';
import '../../core/constants/constants.dart';
import '../../core/routes/app_routes.dart';
import '../../models/verification.dart';
import '../../repository/verify_repository.dart';

class PasswordResetPage extends StatefulWidget {
  String? phoneNumber;
  PasswordResetPage({
    super.key,
    this.phoneNumber,
  });

  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final ResetPasswordRepository _repository = ResetPasswordRepository();

  @override
  Widget build(BuildContext context) {
    // final phoneNumber = ModalRoute.of(context)?.settings.arguments as String?;

    // if (phoneNumber == null) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Phone number is missing')),
    //     );
    //     Navigator.pop(context);
    //   });
    //   return const SizedBox.shrink();
    // }
    String? _phoneNumber;

    // Function to load the phone number from SharedPreferences
    Future<void> _loadPhoneNumber() async {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _phoneNumber = prefs.getString('phoneNumber');
      });
    }

    @override
    void initState() {
      super.initState();
      log(_phoneNumber.toString());
      log(widget.phoneNumber.toString());
      _loadPhoneNumber();
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('New Password'),
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
                      'Add New Password',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppDefaults.padding * 3),
                    const Text("New Password"),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _newPasswordController,
                      autofocus: true,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter new password',
                      ),
                    ),
                    const SizedBox(height: AppDefaults.padding),
                    const Text("OTP"),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter OTP',
                      ),
                    ),
                    const SizedBox(height: AppDefaults.padding * 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          log(widget.phoneNumber.toString(), name: "Number");
                          await _resetPassword(widget.phoneNumber.toString());
                        },
                        child: const Text('Done'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _resetPassword(String phone) async {
    final model = ResetPasswordModel(
      phone: phone,
      otp: _otpController.text,
      newPassword: _newPasswordController.text,
      confirmPassword: _newPasswordController.text,
    );

    try {
      final message = await _repository.resetPassword(model);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      log(message.toString());
      Navigator.pushNamed(context, AppRoutes.login);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      log(e.toString());
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }
}
