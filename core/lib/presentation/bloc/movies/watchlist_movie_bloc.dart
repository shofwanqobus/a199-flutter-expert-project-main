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
      Emitter<WatchlistMoviesState> emit) async {
    emit(WatchlistMoviesLoading());
    final hasil = await getWatchlistMovies.execute();
    hasil.fold(
      (failure) => emit(WatchlistMoviesError(failure.message)),
      (data) => data.isNotEmpty
          ? emit(WatchlistMoviesData(data))
          : emit(WatchlistMoviesEmpty()),
    );
  }
}
