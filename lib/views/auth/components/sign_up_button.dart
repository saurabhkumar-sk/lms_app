import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gyanavi_academy/views/auth/number_verification_page.dart';
import '../../../bloc/auth/signup_state.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';

class SignUpButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignUpButton({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          print('Signup Successful! Navigating to number verification screen.');
          // Navigator.pushNamed(context, AppRoutes.numberVerification);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NumberVerificationPage(
                phoneNumber: phoneController.text,
              ),
            ),
          );
        } else if (state is SignupFailure) {
          print('Signup Failed: ${state.error}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding:
          const EdgeInsets.symmetric(vertical: AppDefaults.padding * 2),
          child: Row(
            children: [
              Text(
                'Sign Up',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: state is SignupLoading
                    ? null
                    : () {
                  // Prepare the payload for the signup request
                  final name = nameController.text.trim();
                  final email = emailController.text.trim();
                  final phone = phoneController.text.trim();
                  final password = passwordController.text.trim();
                  final password_confirmation =
                  confirmPasswordController.text.trim();

                  // Check if password and confirm password match
                  if (password != password_confirmation) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Passwords do not match!')),
                    );
                    return;
                  }

                  // Dispatch the SignupSubmitted event
                  context.read<SignupBloc>().add(
                    SignupSubmitted(
                      name: name,
                      email: email,
                      phone: phone,
                      password: password,
                      password_confirmation: password_confirmation,
                    ),
                  );
                  log("Name : " +
                      name +
                      "  Email : " +
                      email +
                      "  Phone : " +
                      phone +
                      "  Password : " +
                      password +
                      "  confirm pass : " +
                      password_confirmation);
                },
                style: ElevatedButton.styleFrom(elevation: 1),
                child: state is SignupLoading
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
                    : SvgPicture.asset(
                  AppIcons.arrowForward,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
