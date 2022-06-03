import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc({
    required this.getNowPlayingMovies,
  }) : super(NowPlayingMoviesEmpty()) {
    on<FetchNowPlayingMovies>(_fetchNowPlayingMovies);
  }

  void _fetchNowPlayingMovies(FetchNowPlayingMovies fetchNowPlayingMovies,
      Emitter<NowPlayingMoviesState> emitter) async {
    emitter(NowPlayingMoviesLoading());
    final detailResult = await getNowPlayingMovies.execute();
    detailResult.fold(
      (failure) => emitter(NowPlayingMoviesError(failure.message)),
      (data) => emitter(NowPlayingMoviesData(data)),
    );
  }
}
