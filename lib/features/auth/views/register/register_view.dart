import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/bloc/register/register_bloc.dart';
import 'package:jr_case_boilerplate/bloc/register/register_event.dart';
import 'package:jr_case_boilerplate/bloc/register/register_state.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/core/data/models/register_request_model.dart';
import 'package:jr_case_boilerplate/core/widgets/background/custom_background.dart';
import 'package:jr_case_boilerplate/cubit/validation/validation_cubit.dart';
import 'package:jr_case_boilerplate/cubit/validation/validation_state.dart';
import 'package:jr_case_boilerplate/features/auth/views/login/login_view.dart';
import 'package:jr_case_boilerplate/features/auth/views/register/widgets/register_header.dart';
import 'package:jr_case_boilerplate/features/auth/views/register/widgets/register_form.dart';
import 'package:jr_case_boilerplate/features/auth/views/register/widgets/login_redirect.dart';
import 'package:jr_case_boilerplate/features/auth/widgets/social_buttons.dart';

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
  final _formKey = GlobalKey<FormState>();

  bool _isTermsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomBackground(
        gradientStart: AppColors.primary,
        gradientMiddle: AppColors.primaryDark.withOpacity(0.5),
        child: BlocProvider(
          create: (_) => FormValidationCubit(),
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                context.read<FormValidationCubit>().clearErrors();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginView()),
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
                      // 🔹 Üst başlık
                      RegisterHeader(height: size.height),

                      // 🔹 Form
                      RegisterForm(
                        nameController: _nameController,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                        isTermsAccepted: _isTermsAccepted,
                        onTermsChanged: (value) =>
                            setState(() => _isTermsAccepted = value ?? false),
                        onRegisterPressed: () => _handleRegister(context),
                        formKey: _formKey,
                      ),
                      const SizedBox(height: 20),

                      SocialButtons(width: size.width),
                      const SizedBox(height: 16),

                      LoginRedirect(width: size.width),

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
      ),
    );
  }

  void _handleRegister(BuildContext context) {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    context.read<FormValidationCubit>().validateRegisterForm(
      name,
      email,
      password,
      confirmPassword,
    );

    if (!_isTermsAccepted) {
      _showError("Koşulları kabul etmelisiniz!");
      return;
    }

    final validationState = context.read<FormValidationCubit>().state;
    if (validationState is FormValidationUpdated && validationState.isValid) {
      final model = RegisterRequestModel(
        email: email,
        name: name,
        password: password,
      );
      context.read<RegisterBloc>().add(RegisterSubmitted(model));
    } else {
      _showError("Lütfen tüm alanları doğru şekilde doldurun!");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.error,
      ),
    );
  }
}
