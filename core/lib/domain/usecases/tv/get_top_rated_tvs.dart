import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class GetTopRatedTvs {
  final TVRepository repository;

  GetTopRatedTvs(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getTopRatedTvs();
  }
}
