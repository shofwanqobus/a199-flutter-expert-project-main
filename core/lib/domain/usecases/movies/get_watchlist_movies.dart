import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/core.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
