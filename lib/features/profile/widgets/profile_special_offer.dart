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
            SizedBox(width: 4),
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
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF8B1538), Color(0xFF2C0A0A)],
              stops: [0.0, 1.0],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sınırlı Teklif',
                      style: AppTextStyles.heading24.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Description
              Container(
                width: double.infinity,
                color: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
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
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24, width: 1),
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
                        _buildBonusItem(Icons.star, 'Premium\nHesap'),
                        _buildBonusItem(Icons.favorite, 'Daha\nFazla Eşleşme'),
                        _buildBonusItem(Icons.arrow_upward, 'Öne\nÇıkarma'),
                        _buildBonusItem(
                          Icons.favorite_border,
                          'Daha\nFazla Beğeni',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Packages Title
              Container(
                width: double.infinity,
                color: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Text(
                  'Kilidi açmak için bir jeton paketi seçin',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 16),

              // Packages
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildPackageCard(
                          discount: '+10%',
                          oldAmount: '200',
                          newAmount: '300',
                          price: '₺99,99',
                          subtitle: 'Başına haftalık',
                          isPopular: false,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildPackageCard(
                          discount: '+70%',
                          oldAmount: '2.000',
                          newAmount: '3.375',
                          price: '₺799,99',
                          subtitle: 'Başına haftalık',
                          isPopular: true,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildPackageCard(
                          discount: '+35%',
                          oldAmount: '1.000',
                          newAmount: '1.350',
                          price: '₺399,99',
                          subtitle: 'Başına haftalık',
                          isPopular: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Buy Button - CustomElevatedButton kullanımı
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(16.0),
                child: CustomElevatedButton(
                  text: 'Tüm Jetonları Gör',
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.whiteColor,
                  onPressed: () {
                    // Buton işlevi
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBonusItem(IconData icon, String text) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.3),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.red.withOpacity(0.5)),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
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

  Widget _buildPackageCard({
    required String discount,
    required String oldAmount,
    required String newAmount,
    required String price,
    required String subtitle,
    required bool isPopular,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isPopular
              ? [const Color(0xFF9333EA), const Color(0xFF7C3AED)]
              : [const Color(0xFFDC2626), const Color(0xFFB91C1C)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: isPopular
            ? Border.all(color: Colors.purple.shade300, width: 2)
            : null,
      ),
      child: Column(
        children: [
          // Discount Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              discount,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Old Amount (crossed out)
          Text(
            oldAmount,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.whiteColor,
              decoration: TextDecoration.lineThrough,
            ),
          ),

          // New Amount
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

          const SizedBox(height: 16),

          // Price
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
    );
  }
}
