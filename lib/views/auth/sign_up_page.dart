import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth/signup_state.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
import '../../repository/signup_repository.dart';
import 'components/sign_up_form.dart';
import 'components/sign_up_page_header.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Create controllers for each form field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create an instance of SignupRepository
    final signupRepository = SignupRepository();

    return BlocProvider(
      // Pass the signupRepository to the SignupBloc
      create: (context) => SignupBloc(signupRepository: signupRepository),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldWithBoxBackground,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SignUpPageHeader(),
                  const SizedBox(height: AppDefaults.padding),
                  // Passing the controllers to SignUpForm
                  SignUpForm(
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
