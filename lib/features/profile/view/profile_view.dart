import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/bloc/profile/profile_bloc.dart';
import 'package:jr_case_boilerplate/bloc/profile/profile_event.dart';
import 'package:jr_case_boilerplate/bloc/profile/profile_state.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/cubit/favorite_movies/favorite_movie_list_cubit.dart';
import 'package:jr_case_boilerplate/cubit/favorite_movies/favorite_movie_list_state.dart';

import 'package:jr_case_boilerplate/features/profile/widgets/profile_header.dart';
import 'package:jr_case_boilerplate/features/profile/widgets/profile_movie_card.dart';
import 'package:jr_case_boilerplate/features/profile/widgets/profile_special_offer.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const Color primaryDark = Color(0xFF6F060B);
  static const Color blackColor = Color(0xFF000000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primaryDark, blackColor],
            stops: [0.25, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: RefreshIndicator(
              color: Colors.white,
              backgroundColor: primaryDark,
              onRefresh: () async {
                context.read<ProfileBloc>().add(LoadProfile());
                context.read<FavoriteMovieListCubit>().fetchFavorites();
                await Future.delayed(const Duration(milliseconds: 500));
              },
              child: Column(
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
                      if (state is ProfileLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      } else if (state is ProfileError) {
                        return Center(
                          child: Text(
                            'Hata: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (state is ProfileLoaded ||
                          state is ProfileUpdated) {
                        final profile = state is ProfileLoaded
                            ? state.profile
                            : (state as ProfileUpdated).profile;

                        return ProfileHeader(
                          name: profile.name,
                          id: profile.id,
                          photoUrl: profile.photoUrl,
                        );
                      }
                      return const ProfileHeader(
                        name: 'Yükleniyor...',
                        id: '---',
                        photoUrl: '',
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
                    child: BlocBuilder<FavoriteMovieListCubit, FavoriteMovieListState>(
                      builder: (context, state) {
                        if (state is FavoriteLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        } else if (state is FavoriteError) {
                          return ListView(
                            physics:
                                const AlwaysScrollableScrollPhysics(), // ✅ Scroll zorunlu
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(40),
                                  child: Text(
                                    'Hata: ${state.message}',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (state is FavoriteLoaded) {
                          final movies = state.movies;
                          if (movies.isEmpty) {
                            return ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: const [
                                SizedBox(height: 150),
                                Center(
                                  child: Text(
                                    'Henüz favori film yok.',
                                    style: TextStyle(color: Colors.white),
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
                          physics:
                              const AlwaysScrollableScrollPhysics(), // ✅ boş durumda da refresh çalışır
                          children: const [
                            SizedBox(height: 150),
                            Center(
                              child: Text(
                                'Yükleniyor...',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
