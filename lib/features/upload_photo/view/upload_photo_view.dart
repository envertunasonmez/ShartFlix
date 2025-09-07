import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/widgets/background/custom_background.dart';
import 'package:jr_case_boilerplate/features/upload_photo/view/widgets/action_button_section.dart';
import 'package:jr_case_boilerplate/features/upload_photo/view/widgets/header_section.dart';
import 'package:jr_case_boilerplate/features/upload_photo/view/widgets/photo_upload_section.dart';
import 'package:jr_case_boilerplate/features/upload_photo/view/widgets/profile_info_section.dart';

class UploadPhotoView extends StatefulWidget {
  const UploadPhotoView({super.key});

  @override
  State<UploadPhotoView> createState() => _UploadPhotoViewState();
}

class _UploadPhotoViewState extends State<UploadPhotoView> {
  bool _isPhotoSelected = false;
  ImageProvider? _selectedImage;

  void _pickImage() {
    setState(() {
      _isPhotoSelected = true;
      // _selectedImage = ...; // seçilen resmi ata
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        HeaderSection(),
                        SizedBox(height: size.height * 0.08),
                        ProfileInfoSection(),
                        const SizedBox(height: 70),
                        PhotoUploadSection(
                          selectedImage: _selectedImage,
                          onPickImage: _pickImage,
                        ),
                        const SizedBox(height: 160),
                        ActionButtonsSection(isPhotoSelected: _isPhotoSelected),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
