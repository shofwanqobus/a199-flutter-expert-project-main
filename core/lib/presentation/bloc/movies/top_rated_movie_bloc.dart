import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/usecases/movies/get_top_rated_movies.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc({
    required this.getTopRatedMovies,
  }) : super(TopRatedMoviesEmpty()) {
    on<FetchTopRatedMovies>(_fetchTopRatedMovies);
  }

  void _fetchTopRatedMovies(FetchTopRatedMovies fetchTopRatedMovies,
      Emitter<TopRatedMoviesState> emitter) async {
    emitter(TopRatedMoviesLoading());
    final hasil = await getTopRatedMovies.execute();
    hasil.fold(
      (failure) => emitter(TopRatedMoviesError(failure.message)),
      (data) => emitter(TopRatedMoviesData(data)),
    );
  }
}
