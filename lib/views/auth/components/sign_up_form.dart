import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/validators.dart';
import 'sign_up_button.dart';
import 'already_have_accout.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();  // New Email Controller
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.margin),
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppDefaults.boxShadow,
        borderRadius: AppDefaults.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Name"),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController,  // Controller for Name
            validator: Validators.requiredWithFieldName('Name').call,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppDefaults.padding),

          const Text("Email"),  // New Email Field
          const SizedBox(height: 8),
          TextFormField(
            controller: _emailController,  // Controller for Email
            validator: Validators.requiredWithFieldName('Email').call,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppDefaults.padding),

          const Text("Phone Number"),
          const SizedBox(height: 8),
          TextFormField(
            controller: _phoneController,  // Controller for Phone
            validator: Validators.required.call,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppDefaults.padding),

          const Text("Password"),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,  // Controller for Password
            validator: Validators.required.call,
            obscureText: true,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              suffixIcon: Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppIcons.eye,
                    width: 24,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDefaults.padding),

          const Text("Confirm Password"),
          const SizedBox(height: 8),
          TextFormField(
            controller: _confirmPasswordController,  // Controller for Password
            validator: Validators.required.call,
            obscureText: true,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              suffixIcon: Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppIcons.eye,
                    width: 24,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDefaults.padding),

          // Pass controllers to SignUpButton
          SignUpButton(
            nameController: _nameController,
            emailController: _emailController,
            phoneController: _phoneController,
            passwordController: _passwordController,
            confirmPasswordController: _confirmPasswordController,
          ),
          const AlreadyHaveAnAccount(),
          const SizedBox(height: AppDefaults.padding),
        ],
      ),
    );
  }
}
