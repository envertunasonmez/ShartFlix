import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/cubit/favorite/favorite_cubit.dart';
import 'package:jr_case_boilerplate/cubit/favorite/favorite_state.dart';
import 'package:jr_case_boilerplate/features/home/widgets/movie_info_section.dart';
import '../widgets/fav_button.dart';

class HomeMovieListItem extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final String movieId;
  final Function(bool isFav)? onFavTap;

  const HomeMovieListItem({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.movieId,
    this.onFavTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            fit: BoxFit.fill,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
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
          child: BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              final isFav = context.read<FavoriteCubit>().isFavorite(movieId);

              return FavButton(
                isFav: isFav,
                onTap: () {
                  context.read<FavoriteCubit>().toggleFavorite(movieId);
                  onFavTap?.call(!isFav);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
