import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/usecases/movies/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMoviesBloc({
    required this.getWatchlistMovies,
  }) : super(WatchlistMoviesEmpty()) {
    on<FetchWatchlistMovies>(_fetchWatchlistMovies);
  }

  void _fetchWatchlistMovies(FetchWatchlistMovies fetchWatchlistMovies,
      Emitter<WatchlistMoviesState> emitter) async {
    emitter(WatchlistMoviesLoading());
    final hasil = await getWatchlistMovies.execute();
    hasil.fold(
      (failure) => emitter(WatchlistMoviesError(failure.message)),
      (data) => data.isNotEmpty
          ? emitter(WatchlistMoviesData(data))
          : emitter(WatchlistMoviesEmpty()),
    );
  }
}
