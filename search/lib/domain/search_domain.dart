import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class SearchMovies {
  final MovieRepository repo;

  SearchMovies(this.repo);

  Future<Either<Failure, List<Movie>>> execute(String q) {
    return repo.searchMovies(q);
  }
}

class SearchTV {
  final TVRepository repo;

  SearchTV(this.repo);

  Future<Either<Failure, List<TV>>> execute(String q) {
    return repo.searchTvs(q);
  }
}
