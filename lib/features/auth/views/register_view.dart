import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/widgets/text_form_field/custom_text_form_field.dart';

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
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Kayıt Ol",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // 🔹 Custom TextFields
                CustomTextField(
                  controller: _nameController,
                  labelText: "Ad Soyad",
                  svgIconPath: AppStrings.userIconPath,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  controller: _emailController,
                  labelText: "Email",
                  svgIconPath: AppStrings.emailIconPath,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  controller: _passwordController,
                  labelText: "Şifre",
                  svgIconPath: AppStrings.passwordIconPath,
                  obscureText: true,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  controller: _confirmPasswordController,
                  labelText: "Şifre (Tekrar)",
                  svgIconPath: AppStrings.passwordIconPath,
                  obscureText: true,
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Checkbox(
                      value: _isTermsAccepted,
                      onChanged: (value) {
                        setState(() => _isTermsAccepted = value ?? false);
                      },
                    ),
                    const Expanded(
                      child: Text(
                        "Kayıt olarak kullanım koşullarını kabul etmiş oluyorum.",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (_isTermsAccepted) {
                      if (_passwordController.text ==
                          _confirmPasswordController.text) {
                        debugPrint(
                          "✅ Kayıt başarılı: ${_nameController.text}, ${_emailController.text}",
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Şifreler eşleşmiyor!")),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Koşulları kabul etmelisiniz!"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Kayıt Ol"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
