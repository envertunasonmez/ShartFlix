import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import '../widgets/expandable_text.dart';

class MovieInfoSection extends StatelessWidget {
  final String title;
  final String description;

  const MovieInfoSection({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(
          child: SvgPicture.asset(
            AppStrings.circleLogo,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTextStyles.heading18.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              const SizedBox(height: 4),
              ExpandableText(text: description, trimLines: 1),
            ],
          ),
        ),
      ],
    );
  }
}
