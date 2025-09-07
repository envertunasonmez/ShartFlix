import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/features/home/widgets/movie_info_section.dart';
import '../widgets/fav_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isFav = false;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Image.asset(AppStrings.homeImage, fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 280,
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 0.33, 1.0],
                  colors: [
                    AppColors.blackColor,
                    AppColors.blackColor,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          const MovieInfoSection(
            title: 'Son Ana Kadar',
            description:
                'Bugünün favori filmi: Çok uzun bir açıklama örneği burada gösterilecek.',
          ),
          Positioned(
            bottom: 200,
            right: 20,
            child: StatefulBuilder(
              builder: (context, setState) => FavButton(
                isFav: isFav,
                onTap: () => setState(() {
                  isFav = !isFav;
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
