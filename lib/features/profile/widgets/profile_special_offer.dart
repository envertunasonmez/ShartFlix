import 'dart:ui';

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

// --------------------- Special Offer Bottom Sheet ---------------------

class SpecialOfferBottomSheet extends StatefulWidget {
  const SpecialOfferBottomSheet({super.key});

  @override
  State<SpecialOfferBottomSheet> createState() =>
      _SpecialOfferBottomSheetState();
}

class _SpecialOfferBottomSheetState extends State<SpecialOfferBottomSheet> {
  int selectedIndex = 0;

  final List<Map<String, String>> packages = [
    {
      'discount': '+10%',
      'old': '200',
      'new': '300',
      'price': '₺99,99',
      'subtitle': 'Başına haftalık',
    },
    {
      'discount': '+70%',
      'old': '2.000',
      'new': '3.375',
      'price': '₺799,99',
      'subtitle': 'Başına haftalık',
    },
    {
      'discount': '+35%',
      'old': '1.000',
      'new': '1.350',
      'price': '₺399,99',
      'subtitle': 'Başına haftalık',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.78,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryDark,
                Colors.black,
                AppColors.primaryDark,
              ],
              stops: [0.0, 0.4, 1.0],
            ),
          ),
          child: Column(
            children: [
              const _SheetHeader(),
              const SizedBox(height: 12),
              const _SheetDescription(),
              const SizedBox(height: 24),
              const _BonusesSection(),
              const SizedBox(height: 24),
              const _PackagesTitle(),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(packages.length, (index) {
                      final pkg = packages[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: PackageCard(
                          discount: pkg['discount']!,
                          oldAmount: pkg['old']!,
                          newAmount: pkg['new']!,
                          price: pkg['price']!,
                          subtitle: pkg['subtitle']!,
                          isSelected: selectedIndex == index,
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const _BuyButton(),
            ],
          ),
        );
      },
    );
  }
}

// --------------------- Sub Widgets ---------------------

class _SheetHeader extends StatelessWidget {
  const _SheetHeader();
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _SheetDescription extends StatelessWidget {
  const _SheetDescription();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Jeton paketini seçerek bonus kazanın ve yeni bölümlerin kilidini açın!',
        style: AppTextStyles.bodyNormal.copyWith(color: AppColors.white90),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _BonusesSection extends StatelessWidget {
  const _BonusesSection();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white5,
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
            children: const [
              BonusItem(
                assetPath: AppStrings.premiumAcc,
                text: 'Premium\nHesap',
              ),
              BonusItem(
                assetPath: AppStrings.moreMatches,
                text: 'Daha\nFazla Eşleşme',
              ),
              BonusItem(assetPath: AppStrings.highlight, text: 'Öne\nÇıkarma'),
              BonusItem(
                assetPath: AppStrings.moreLikes,
                text: 'Daha\nFazla Beğeni',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BonusItem extends StatelessWidget {
  final String assetPath;
  final String text;
  const BonusItem({required this.assetPath, required this.text});

  @override
  Widget build(BuildContext context) {
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
}

class _PackagesTitle extends StatelessWidget {
  const _PackagesTitle();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Kilidi açmak için bir jeton paketi seçin',
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  final String discount, oldAmount, newAmount, price, subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const PackageCard({
    super.key,
    required this.discount,
    required this.oldAmount,
    required this.newAmount,
    required this.price,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color selectedDiscountColor = const Color(0xFF5949E6);
    final List<Color> normalGradient = [
      const Color(0xFFDC2626),
      const Color(0xFFB91C1C),
    ];
    final double borderRadius = 16;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Kartın arka planı
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: normalGradient,
              ),
            ),
            child: Stack(
              children: [
                if (isSelected)
                  Positioned(
                    top: -70,
                    left: -45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                      ),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          width: 178,
                          height: 280,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Color(0xFF5949E6), // mor
                                Color(0xFFDC2626), // kırmızı geçişli
                                Colors.transparent,
                              ],
                              stops: [0.0, 0.6, 1.0],
                              radius: 1.6,
                              center: Alignment(-0.4, -0.4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                // Kart içeriği
                Padding(
                  padding: const EdgeInsets.all(16),
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
              ],
            ),
          ),
          // Discount alanı
          Positioned(
            top: -12,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? selectedDiscountColor : normalGradient[0],
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: isSelected
                        ? selectedDiscountColor
                        : normalGradient[0],
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
      ),
    );
  }
}

class _BuyButton extends StatelessWidget {
  const _BuyButton();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: CustomElevatedButton(
        text: 'Tüm Jetonları Gör',
        backgroundColor: AppColors.primary,
        textColor: AppColors.whiteColor,
        onPressed: () {},
      ),
    );
  }
}
