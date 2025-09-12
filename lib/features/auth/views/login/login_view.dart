import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/widgets/background/custom_background.dart';
import 'package:jr_case_boilerplate/cubit/validation/validation_cubit.dart';
import 'package:jr_case_boilerplate/features/auth/views/login/widgets/login_header.dart';
import 'package:jr_case_boilerplate/features/auth/views/login/widgets/login_form.dart';
import 'package:jr_case_boilerplate/features/auth/views/login/widgets/register_redirect.dart';
import 'package:jr_case_boilerplate/features/auth/widgets/social_buttons.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: CustomBackground(
        gradientStart: AppColors.primary,
        gradientMiddle: AppColors.primaryDark.withOpacity(0.5),
        child: BlocProvider(
          create: (context) => FormValidationCubit(),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LoginHeader(height: height, width: width),
                  LoginForm(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    width: width,
                    formKey: _formKey,
                  ),
                  const SizedBox(height: 20),
                  SocialButtons(width: width),
                  const SizedBox(height: 16),
                  RegisterRedirect(width: width),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
