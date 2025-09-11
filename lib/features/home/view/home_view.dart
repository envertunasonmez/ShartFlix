import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/bloc/movie_list/movie_list_bloc.dart';
import 'package:jr_case_boilerplate/bloc/movie_list/movie_list_state.dart';
import 'package:jr_case_boilerplate/features/home/widgets/home_movie_list_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const _NoGlowScrollBehavior(),
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieLoaded) {
              final movies = state.response.movies;

              return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return HomeMovieListItem(
                    title: movie.title,
                    description: movie.description,
                    image: movie.posterUrl,
                    movieId: movie.id,
                    onFavTap: (isFav) {
                      print("Fav durumu değişti: $isFav, film id: ${movie.id}");
                    },
                  );
                },
              );
            } else if (state is MovieError) {
              return Center(child: Text("Hata: ${state.message}"));
            } else {
              return const Center(child: Text("Film bulunamadı"));
            }
          },
        ),
      ),
    );
  }
}

class _NoGlowScrollBehavior extends ScrollBehavior {
  const _NoGlowScrollBehavior();
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
