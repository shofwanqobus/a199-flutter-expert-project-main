import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/presentation/bloc/movies/now_playing_movie_bloc.dart';
import 'package:core/presentation/bloc/movies/popular_movie_bloc.dart';
import 'package:core/presentation/bloc/movies/top_rated_movie_bloc.dart';
import 'package:flutter/material.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePage createState() => _HomeMoviePage();
}

class _HomeMoviePage extends State<HomeMoviePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('Now Playing Movies', style: kHeading6),
        ),
        BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
          builder: (_, state) {
            if (state is NowPlayingMoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NowPlayingMoviesData) {
              return MovieList(state.movie);
            } else {
              return const Text('Failed');
            }
          },
        ),
        _buildSubHeading(
            title: 'Popular Movies',
            onTap: () => Navigator.pushNamed(context, POPULAR_MOVIES_ROUTE)),
        BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (_, state) {
            if (state is PopularMoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PopularMoviesData) {
              return MovieList(state.movie);
            } else {
              return const Text('Failed');
            }
          },
        ),
        _buildSubHeading(
            title: 'Top Rated Movies',
            onTap: () => Navigator.pushNamed(context, TOP_RATED_ROUTE)),
        BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
          builder: (_, state) {
            if (state is TopRatedMoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TopRatedMoviesData) {
              return MovieList(state.movie);
            } else {
              return const Text('Failed');
            }
          },
        ),
      ],
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final data = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MOVIE_DETAIL_ROUTE,
                  arguments: data.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${data.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
