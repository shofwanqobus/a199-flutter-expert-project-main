import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class GetPopularTvs {
  final TVRepository repository;

  GetPopularTvs(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getPopularTvs();
  }
}
