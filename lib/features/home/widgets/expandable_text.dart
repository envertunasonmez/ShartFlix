import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;

  const ExpandableText({super.key, required this.text, this.trimLines = 1});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // TextPainter ile overflow kontrolü
        final span = TextSpan(
          text: widget.text,
          style: AppTextStyles.bodyNormal.copyWith(color: AppColors.white80),
        );
        final tp = TextPainter(
          text: span,
          maxLines: widget.trimLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflow = tp.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              maxLines: isExpanded ? null : widget.trimLines,
              overflow: isExpanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              style: AppTextStyles.bodyNormal.copyWith(
                color: AppColors.white80,
              ),
            ),
            if (isOverflow)
              GestureDetector(
                onTap: () => setState(() => isExpanded = !isExpanded),
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    isExpanded ? 'Kapat' : 'Devamını gör',
                    style: AppTextStyles.bodyNormal.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
