

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/bloc/profile/profile_bloc.dart';
import 'package:jr_case_boilerplate/bloc/profile/profile_event.dart';
import 'package:jr_case_boilerplate/bloc/profile/profile_state.dart';
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Profil',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const ProfileSpecialOffer(),
                  ],
                ),

                const SizedBox(height: 24),

                // Profile Section with BLoC
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }
                    
                    if (state is ProfileError) {
                      return Center(
                        child: Text(
                          'Hata: ${state.message}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    
                    if (state is ProfileLoaded || state is ProfileUpdated) {
                      final profile = state is ProfileLoaded 
                          ? state.profile 
                          : (state as ProfileUpdated).profile;
                      
                      return ProfileHeader(
                        name: profile.name,
                        id: profile.id,
                        photoUrl: profile.photoUrl,
                      );
                    }
                    
                    // Initial state - trigger profile load
                    if (state is ProfileInitial) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context.read<ProfileBloc>().add(LoadProfile());
                      });
                    }
                    
                    return const ProfileHeader(
                      name: 'Yükleniyor...',
                      id: '---',
                      photoUrl: '',
                    );
                  },
                ),

                const SizedBox(height: 32),

                // Beğendiklerim Section
                const Text(
                  'Beğendiklerim',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // Movies Grid
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                    children: const [
                      ProfileMovieCard(
                        title: 'LOVE\nAGAIN',
                        subtitle: 'Aşk Yeniden',
                        studio: 'Sony',
                        accentColor: Colors.blue,
                      ),
                      ProfileMovieCard(
                        title: 'PAST\nLIVES',
                        subtitle: 'Başka Bir Hayatta',
                        studio: 'A24',
                        accentColor: Colors.grey,
                      ),
                      ProfileMovieCard(
                        title: 'ANYONE\nBUT YOU',
                        subtitle: 'Senden Başka',
                        studio: 'Columbia',
                        accentColor: Colors.green,
                      ),
                      ProfileMovieCard(
                        title: 'Culpa\nMía',
                        subtitle: 'Culpa mía',
                        studio: 'Netflix',
                        accentColor: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}