import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/bloc/profile/profile_bloc.dart';
import 'package:jr_case_boilerplate/bloc/profile/profile_event.dart';
import 'package:jr_case_boilerplate/bloc/profile/profile_state.dart';
import 'package:jr_case_boilerplate/core/widgets/background/custom_background.dart';
import 'package:jr_case_boilerplate/cubit/favorite_movies/favorite_movie_list_cubit.dart';
import 'package:jr_case_boilerplate/cubit/favorite_movies/favorite_movie_list_state.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';

import 'package:jr_case_boilerplate/features/profile/widgets/profile_header.dart';
import 'package:jr_case_boilerplate/features/profile/widgets/profile_movie_card.dart';
import 'package:jr_case_boilerplate/features/profile/widgets/profile_special_offer.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final isRefreshing = ValueNotifier<bool>(false);

    return Scaffold(
      body: CustomBackground(
        gradientStart: AppColors.primaryDark.withOpacity(0.5),
        gradientMiddle: AppColors.primaryDark.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: RefreshIndicator(
            color: AppColors.primary,
            backgroundColor: AppColors.blackColor,
            onRefresh: () async {
              isRefreshing.value = true;

              // Profile ve favorite reload
              context.read<ProfileBloc>().add(LoadProfile());
              context.read<FavoriteMovieListCubit>().fetchFavorites();

              await Future.delayed(const Duration(milliseconds: 500));

              isRefreshing.value = false;
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header + Special Offer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profil',
                          style: AppTextStyles.heading20.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        const ProfileSpecialOffer(),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Profile Info with BLoC
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        final profile = state is ProfileLoaded
                            ? state.profile
                            : (state is ProfileUpdated ? state.profile : null);

                        return ProfileHeader(
                          name: profile?.name ?? 'Yükleniyor...',
                          id: profile?.id ?? '---',
                          photoUrl: profile?.photoUrl ?? '',
                        );
                      },
                    ),

                    const SizedBox(height: 32),
                    Text(
                      'Beğendiklerim',
                      style: AppTextStyles.heading18.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Favorites Grid
                    Expanded(
                      child:
                          BlocBuilder<
                            FavoriteMovieListCubit,
                            FavoriteMovieListState
                          >(
                            builder: (context, state) {
                              if (state is FavoriteLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                );
                              } else if (state is FavoriteError) {
                                return ListView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(40),
                                        child: Text(
                                          'Hata: ${state.message}',
                                          style: AppTextStyles.bodyNormal
                                              .copyWith(
                                                color: AppColors.primary,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (state is FavoriteLoaded) {
                                final movies = state.movies;

                                if (movies.isEmpty) {
                                  return ListView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    children: [
                                      SizedBox(height: 150),
                                      Center(
                                        child: Text(
                                          'Henüz favori film yok.',
                                          style: AppTextStyles.bodyNormal
                                              .copyWith(
                                                color: AppColors.whiteColor,
                                              ),
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 12,
                                        childAspectRatio: 0.6,
                                      ),
                                  itemCount: movies.length,
                                  itemBuilder: (context, index) {
                                    final movie = movies[index];
                                    return ProfileMovieCard(
                                      title: movie.title,
                                      description: movie.description,
                                      posterUrl: movie.posterUrl,
                                      accentColor: Colors.blueAccent,
                                    );
                                  },
                                );
                              }

                              return ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: [
                                  SizedBox(height: 150),
                                  Center(
                                    child: Text(
                                      'Yükleniyor...',
                                      style: AppTextStyles.bodyNormal.copyWith(
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
