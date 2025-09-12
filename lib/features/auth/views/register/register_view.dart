import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/bloc/register/register_bloc.dart';
import 'package:jr_case_boilerplate/bloc/register/register_event.dart';
import 'package:jr_case_boilerplate/bloc/register/register_state.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/data/models/register_request_model.dart';
import 'package:jr_case_boilerplate/core/widgets/background/custom_background.dart';
import 'package:jr_case_boilerplate/features/auth/views/login/login_view.dart';
import 'package:jr_case_boilerplate/features/auth/views/register/widgets/register_header.dart';
import 'package:jr_case_boilerplate/features/auth/views/register/widgets/register_form.dart';
import 'package:jr_case_boilerplate/features/auth/widgets/social_buttons.dart';
import 'package:jr_case_boilerplate/features/auth/views/register/widgets/login_redirect.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomBackground(
        gradientStart: AppColors.primary,
        gradientMiddle: AppColors.primaryDark.withOpacity(0.5),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "✅ Kayıt başarılı",
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  backgroundColor: AppColors.success,
                ),
              );
            } else if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "❌ Hata: ${state.error}",
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RegisterHeader(height: height),
                    RegisterForm(
                      nameController: _nameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      isTermsAccepted: _isTermsAccepted,
                      onTermsChanged: (value) =>
                          setState(() => _isTermsAccepted = value ?? false),
                      onRegisterPressed: () => _handleRegister(context),
                    ),
                    const SizedBox(height: 20),
                    SocialButtons(width: width),
                    const SizedBox(height: 16),
                    LoginRedirect(width: width),
                    if (state is RegisterLoading)
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleRegister(BuildContext context) {
    if (_isTermsAccepted) {
      if (_passwordController.text == _confirmPasswordController.text) {
        final model = RegisterRequestModel(
          email: _emailController.text,
          name: _nameController.text,
          password: _passwordController.text,
        );
        context.read<RegisterBloc>().add(RegisterSubmitted(model));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Şifreler eşleşmiyor!",
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Koşulları kabul etmelisiniz!",
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ),
      );
    }
  }
}
