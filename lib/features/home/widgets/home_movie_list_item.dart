import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/features/home/widgets/movie_info_section.dart';
import '../widgets/fav_button.dart';

class HomeMovieListItem extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final Function(bool isFav)? onFavTap;

  const HomeMovieListItem({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    this.onFavTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isFav = false;
    // HTTP -> HTTPS 
    final imageUrl = image.startsWith("http://")
        ? image.replaceFirst("http://", "https://")
        : image;

    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
              ),
            ),
          ),
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
        MovieInfoSection(title: title, description: description),
        Positioned(
          bottom: 200,
          right: 20,
          child: StatefulBuilder(
            builder: (context, setState) => FavButton(
              isFav: isFav,
              onTap: () {
                setState(() => isFav = !isFav);
                onFavTap?.call(isFav);
              },
            ),
          ),
        ),
      ],
    );
  }
}
