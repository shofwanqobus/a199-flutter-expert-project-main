import 'package:core/core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:core/presentation/bloc/movies/now_playing_movie_bloc.dart';
import 'package:core/presentation/bloc/movies/popular_movie_bloc.dart';
import 'package:core/presentation/bloc/movies/top_rated_movie_bloc.dart';
import 'package:core/presentation/pages/movies/home_movie_page.dart';
import 'package:core/presentation/bloc/tv/now_playing_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:core/presentation/pages/tv/home_tv_page.dart';

import '../widgets/custom_drawers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingMoviesBloc>(context)
          .add(FetchNowPlayingMovies());
      BlocProvider.of<PopularMoviesBloc>(context).add(FetchPopularMovies());
      BlocProvider.of<TopRatedMoviesBloc>(context).add(FetchTopRatedMovies());

      BlocProvider.of<NowPlayingTVBloc>(context).add(FetchNowPlayingTV());
      BlocProvider.of<PopularTVBloc>(context).add(FetchPopularTV());
      BlocProvider.of<TopRatedTVBloc>(context).add(FetchTopRatedTV());
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      content: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          title: const Text('Ditonton'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SEARCH_ROUTE);
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                HomeMoviePage(),
                HomeTVPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
