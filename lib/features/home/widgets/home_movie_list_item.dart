import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/widgets/cached_network_image/custom_cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/cubit/add_favorite/add_favorite_cubit.dart';
import 'package:jr_case_boilerplate/cubit/add_favorite/add_favorite_state.dart';
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

    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              CustomCachedNetworkImage(
                imageUrl: image,
                width: double.infinity,
                height: size.height,
                fit: BoxFit.fill,
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 220,
                child: IgnorePointer(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [AppColors.blackColor, Colors.transparent],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: MovieInfoSection(title: title, description: description),
          ),
        ),
        Positioned(
          bottom: 160,
          right: 20,
          child: BlocBuilder<FavoriteCubit, AddFavoriteState>(
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
