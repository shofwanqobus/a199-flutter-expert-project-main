import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/movies/movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
  }) : super((MovieDetailEmpty())) {
    on<FetchMovieDetail>(_fetchMovieDetail);
  }

  void _fetchMovieDetail(FetchMovieDetail fetchMovieDetail,
      Emitter<MovieDetailState> emitter) async {
    emitter(MovieDetailLoading());
    final detailResult = await getMovieDetail.execute(fetchMovieDetail.id);
    final recommendationResult =
        await getMovieRecommendations.execute(fetchMovieDetail.id);
    detailResult.fold((failure) => emitter(MovieDetailError(failure.message)),
        (detMovie) {
      emitter(MovieDetailLoading());
      recommendationResult.fold(
        (failure) => emitter(MovieDetailError(failure.message)),
        (recMovie) => emitter(
          MovieDetailData(detMovie, recMovie),
        ),
      );
    });
  }
}
