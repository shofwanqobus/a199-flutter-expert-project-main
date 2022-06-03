import 'dart:io';

import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movies/get_popular_movies.dart';
import 'package:core/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movies/get_watchlist_status.dart';
import 'package:core/domain/usecases/movies/remove_watchlist.dart';
import 'package:core/domain/usecases/movies/save_watchlist.dart';
import 'package:core/presentation/bloc/movies/now_playing_movie_bloc.dart';
import 'package:core/presentation/bloc/movies/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movies/popular_movie_bloc.dart';
import 'package:core/presentation/bloc/movies/top_rated_movie_bloc.dart';
import 'package:core/presentation/bloc/movies/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/movies/watchlist_movie_modify_bloc.dart';
import 'package:core/presentation/bloc/movies/watchlist_movie_status_bloc.dart';

import 'package:core/data/datasources/tv_local_data_source.dart';
import 'package:core/data/datasources/tv_remote_data_source.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecases/tv/get_tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_recommendation.dart';
import 'package:core/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:core/domain/usecases/tv/get_popular_tvs.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:core/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:core/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:core/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/remove_watchlist_tvs.dart';
import 'package:core/presentation/bloc/tv/now_playing_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:core/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_modify_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_status_bloc.dart';

import 'package:http/io_client.dart';
import 'package:get_it/get_it.dart';
import 'package:search/domain/search_domain.dart';
import 'package:search/presentation/bloc/movies/search_bloc.dart';
import 'package:search/presentation/bloc/tv/search_bloc.dart';

final locator = GetIt.instance;

void init(HttpClient client) {
  // bloc movies
  locator.registerFactory(
      () => NowPlayingMoviesBloc(getNowPlayingMovies: locator()));
  locator.registerFactory(() => PopularMoviesBloc(getPopularMovies: locator()));
  locator
      .registerFactory(() => TopRatedMoviesBloc(getTopRatedMovies: locator()));
  locator.registerFactory(() => MovieDetailBloc(
      getMovieDetail: locator(), getMovieRecommendations: locator()));
  locator.registerFactory(() => WatchListMoviesModifyBloc(
      saveWatchlist: locator(), removeWatchlist: locator()));
  locator.registerFactory(
      () => WatchListStatusBloc(getWatchListStatus: locator()));
  locator.registerFactory(
      () => WatchlistMoviesBloc(getWatchlistMovies: locator()));
  locator.registerFactory(() => MoviesSearchBloc(movies: locator()));

  // bloc tv
  locator.registerFactory(() => NowPlayingTVBloc(getNowPlayingTV: locator()));
  locator.registerFactory(() => PopularTVBloc(getPopularTV: locator()));
  locator.registerFactory(() => TopRatedTVBloc(getTopRatedTV: locator()));
  locator.registerFactory(() =>
      TVDetailBloc(getTVDetail: locator(), getTVRecommendations: locator()));
  locator.registerFactory(() => WatchListTVModifyBloc(
      saveWatchlist: locator(), removeWatchlist: locator()));
  locator.registerFactory(
      () => TVWatchlistStatusBloc(getTVWatchlistStatus: locator()));
  locator.registerFactory(() => WatchlistTVBloc(getWatchlistTV: locator()));
  locator.registerFactory(() => TVSearchBloc(tv: locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTV(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTV(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => IOClient(client));
}
