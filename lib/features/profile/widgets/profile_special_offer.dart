import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/core/widgets/buttons/custom_elevated_button.dart';

class ProfileSpecialOffer extends StatelessWidget {
  const ProfileSpecialOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSpecialOfferBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppStrings.diamondIcon, width: 20, height: 20),
            const SizedBox(width: 4),
            Text(
              'Sınırlı Teklif',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSpecialOfferBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SpecialOfferBottomSheet(),
    );
  }
}

class SpecialOfferBottomSheet extends StatelessWidget {
  const SpecialOfferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.78,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.primaryDark,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.white50),
                          ),
                          child: SvgPicture.asset(
                            AppStrings.closeIcon,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Sınırlı Teklif',
                      style: AppTextStyles.heading24.copyWith(
                        color: AppColors.whiteColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Jeton paketini seçerek bonus kazanın ve yeni bölümlerin kilidini açın!',
                  style: AppTextStyles.bodyNormal.copyWith(
                    color: AppColors.white90,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 24),

              // Bonuses Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.white20, width: 1),
                ),
                child: Column(
                  children: [
                    Text(
                      'Alacağınız Bonuslar',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildBonusItem(
                          AppStrings.premiumAcc,
                          'Premium\nHesap',
                        ),
                        _buildBonusItem(
                          AppStrings.moreMatches,
                          'Daha\nFazla Eşleşme',
                        ),
                        _buildBonusItem(AppStrings.highlight, 'Öne\nÇıkarma'),
                        _buildBonusItem(
                          AppStrings.moreLikes,
                          'Daha\nFazla Beğeni',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Packages Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Kilidi açmak için bir jeton paketi seçin',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 32),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPackageCard(
                        discount: '+10%',
                        oldAmount: '200',
                        newAmount: '300',
                        price: '₺99,99',
                        subtitle: 'Başına haftalık',
                        isPopular: false,
                        spacing: 16,
                      ),
                      SizedBox(width: 16),
                      _buildPackageCard(
                        discount: '+70%',
                        oldAmount: '2.000',
                        newAmount: '3.375',
                        price: '₺799,99',
                        subtitle: 'Başına haftalık',
                        isPopular: true,
                        spacing: 16,
                      ),
                      SizedBox(width: 16),
                      _buildPackageCard(
                        discount: '+35%',
                        oldAmount: '1.000',
                        newAmount: '1.350',
                        price: '₺399,99',
                        subtitle: 'Başına haftalık',
                        isPopular: false,
                        spacing: 16,
                      ),
                    ],
                  ),
                ),
              ),

              // Buy Button
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: CustomElevatedButton(
                  text: 'Tüm Jetonları Gör',
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.whiteColor,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBonusItem(String assetPath, String text) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.primaryDark,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.red.withOpacity(0.5)),
          ),
          // SVG format didn't work and i couldn't how to fix it
          child: Center(child: Image.asset(assetPath, width: 32, height: 32)),
        ),

        const SizedBox(height: 8),
        Text(
          text,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.whiteColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // _buildPackageCard
  Widget _buildPackageCard({
    required String discount,
    required String oldAmount,
    required String newAmount,
    required String price,
    required String subtitle,
    required bool isPopular,
    required double spacing,
  }) {
    final List<Color> gradientColors = isPopular
        ? [const Color(0xFF9333EA), const Color(0xFF7C3AED)]
        : [const Color(0xFFDC2626), const Color(0xFFB91C1C)];

    final double borderRadius = 16;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
            border: isPopular
                ? Border.all(color: Colors.purple.shade300, width: 2)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    oldAmount,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.whiteColor,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Text(
                    newAmount,
                    style: AppTextStyles.heading32.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Text(
                    'Jeton',
                    style: AppTextStyles.bodyNormal.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    price,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -12,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: gradientColors[0],
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: isPopular
                      ? Colors.purple.shade300
                      : const Color(0xFFB91C1C),
                  width: 2,
                ),
              ),
              child: Text(
                discount,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
