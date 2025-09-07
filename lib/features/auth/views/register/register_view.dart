import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/widgets/background/custom_background.dart';
import 'package:jr_case_boilerplate/features/auth/views/register/widgets/register_header.dart';
import 'package:jr_case_boilerplate/features/auth/views/register/widgets/register_form.dart';
import 'package:jr_case_boilerplate/features/auth/widgets/social_buttons.dart';
import 'package:jr_case_boilerplate/features/auth/views/register/widgets/login_redirect.dart';

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
        child: SingleChildScrollView(
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
                  onRegisterPressed: _handleRegister,
                ),
                const SizedBox(height: 20),
                SocialButtons(width: width),
                const SizedBox(height: 16),
                LoginRedirect(width: width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleRegister() {
    if (_isTermsAccepted) {
      if (_passwordController.text == _confirmPasswordController.text) {
        debugPrint(
          "✅ Kayıt başarılı: ${_nameController.text}, ${_emailController.text}",
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Şifreler eşleşmiyor!")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Koşulları kabul etmelisiniz!")),
      );
    }
  }
}
