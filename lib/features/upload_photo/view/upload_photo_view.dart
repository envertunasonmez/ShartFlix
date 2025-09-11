import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/core/widgets/background/custom_background.dart';
import 'package:jr_case_boilerplate/features/upload_photo/view/widgets/action_button_section.dart';
import 'package:jr_case_boilerplate/features/upload_photo/view/widgets/header_section.dart';
import 'package:jr_case_boilerplate/features/upload_photo/view/widgets/photo_upload_section.dart';
import 'package:jr_case_boilerplate/features/upload_photo/view/widgets/profile_info_section.dart';
import 'package:jr_case_boilerplate/bloc/upload_photo/upload_photo_bloc.dart';
import 'package:jr_case_boilerplate/bloc/upload_photo/upload_photo_event.dart';
import 'package:jr_case_boilerplate/bloc/upload_photo/upload_photo_state.dart';
import 'package:jr_case_boilerplate/core/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

class UploadPhotoView extends StatelessWidget {
  const UploadPhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return BlocBuilder<UploadPhotoBloc, UploadPhotoState>(
                builder: (context, state) {
                  ImageProvider? selectedImage;
                  bool isPhotoSelected = false;
                  if (state is PhotoPickedSuccess) {
                    selectedImage = FileImage(File(state.photoPath));
                    isPhotoSelected = true;
                  }
                  if (state is UploadPhotoSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.go(AppRoutes.mainWrapper);
                    });
                  }
                  return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
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
                              selectedImage: selectedImage,
                              onPickImage: () {
                                context.read<UploadPhotoBloc>().add(
                                  PickPhotoRequested(),
                                );
                              },
                              onRemoveImage: selectedImage != null
                                  ? () {
                                      context.read<UploadPhotoBloc>().add(
                                        RemovePhotoRequested(),
                                      );
                                    }
                                  : null,
                            ),
                            const SizedBox(height: 160),
                            ActionButtonsSection(
                              isPhotoSelected: isPhotoSelected,
                              onUpload: (photoPath) {
                                context.read<UploadPhotoBloc>().add(
                                  UploadPhotoRequested(photoPath),
                                );
                              },
                              photoPath: state is PhotoPickedSuccess
                                  ? state.photoPath
                                  : null,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
